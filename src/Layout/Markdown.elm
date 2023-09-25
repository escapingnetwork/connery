module Layout.Markdown exposing (toHtml)

import Html exposing (Html)
import Html.Attributes as Attrs
import Markdown.Block as Block exposing (Block)
import Markdown.Parser
import Markdown.Renderer exposing (defaultHtmlRenderer)
import Parser exposing (DeadEnd)
import Phosphor
import String.Normalize
import Svg.Attributes as SvgAttrs
import SyntaxHighlight


language : Maybe String -> String -> Result (List DeadEnd) SyntaxHighlight.HCode
language lang =
    case lang of
        Just "elm" ->
            SyntaxHighlight.elm

        _ ->
            SyntaxHighlight.noLang


syntaxHighlight : { a | language : Maybe String, body : String } -> Html msg
syntaxHighlight codeBlock =
    Html.div [ Attrs.class "no-prose" ]
        [ SyntaxHighlight.useTheme SyntaxHighlight.oneDark
        , language codeBlock.language codeBlock.body
            |> Result.map (SyntaxHighlight.toBlockHtml (Just 1))
            |> Result.withDefault
                (Html.pre [] [ Html.code [] [ Html.text codeBlock.body ] ])
        ]


renderer : Markdown.Renderer.Renderer (Html msg)
renderer =
    let
        headingElement level id =
            case level of
                Block.H1 ->
                    Html.h1 [ Attrs.id id ]

                Block.H2 ->
                    Html.h2 [ Attrs.id id ]

                Block.H3 ->
                    Html.h3 [ Attrs.id id ]

                Block.H4 ->
                    Html.h4 [ Attrs.id id ]

                Block.H5 ->
                    Html.h5 [ Attrs.id id ]

                Block.H6 ->
                    Html.h6 [ Attrs.id id ]
    in
    { defaultHtmlRenderer
        | heading =
            \{ level, rawText, children } ->
                let
                    id =
                        String.Normalize.slug rawText
                in
                headingElement level
                    id
                    [ Html.a
                        [ Attrs.href <| "#" ++ id
                        , Attrs.class "not-prose group "
                        ]
                        [ Html.span [ Attrs.class "group-hover:underline decoration-primary-500" ] children
                        , Phosphor.link Phosphor.Thin
                            |> Phosphor.toHtml [ SvgAttrs.class "text-primary-300 inline-block text-xl ml-2" ]
                        ]
                    ]
        , codeBlock =
            \block ->
                syntaxHighlight block
    }


toHtml :
    String
    -> List (Html msg)
toHtml markdownString =
    markdownString
        |> Markdown.Parser.parse
        |> Result.mapError (\_ -> "Markdown error.")
        |> Result.andThen
            (\blocks ->
                Markdown.Renderer.render
                    renderer
                    blocks
            )
        |> Result.withDefault [ Html.text "failed to read markdown" ]
