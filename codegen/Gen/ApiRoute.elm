module Gen.ApiRoute exposing (annotation_, call_, capture, getBuildTimeRoutes, getGlobalHeadTagsBackendTask, literal, moduleName_, preRender, preRenderWithFallback, serverRender, single, slash, succeed, toJson, values_, withGlobalHeadTags)

{-| 
@docs values_, call_, annotation_, getGlobalHeadTagsBackendTask, getBuildTimeRoutes, toJson, withGlobalHeadTags, succeed, slash, literal, capture, preRenderWithFallback, serverRender, preRender, single, moduleName_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "ApiRoute" ]


{-| Same as [`preRender`](#preRender), but for an ApiRoute that has no dynamic segments. This is just a bit simpler because
since there are no dynamic segments, you don't need to provide a BackendTask with the list of dynamic segments to pre-render because there is only a single possible route.

single: 
    ApiRoute.ApiRouteBuilder (BackendTask.BackendTask FatalError.FatalError String) (List String)
    -> ApiRoute.ApiRoute ApiRoute.Response
-}
single : Elm.Expression -> Elm.Expression
single singleArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "single"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.string
                                ]
                            , Type.list Type.string
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
        )
        [ singleArg ]


{-| Pre-render files for a given route pattern statically at build-time. If you only need to serve a single file, you can use [`single`](#single) instead.

    import ApiRoute
    import BackendTask
    import BackendTask.Http
    import Json.Decode as Decode
    import Json.Encode as Encode

    starsApi : ApiRoute ApiRoute.Response
    starsApi =
        ApiRoute.succeed
            (\user repoName ->
                BackendTask.Http.getJson
                    ("https://api.github.com/repos/" ++ user ++ "/" ++ repoName)
                    (Decode.field "stargazers_count" Decode.int)
                    |> BackendTask.allowFatal
                    |> BackendTask.map
                        (\stars ->
                            Encode.object
                                [ ( "repo", Encode.string repoName )
                                , ( "stars", Encode.int stars )
                                ]
                                |> Encode.encode 2
                        )
            )
            |> ApiRoute.literal "repo"
            |> ApiRoute.slash
            |> ApiRoute.capture
            |> ApiRoute.slash
            |> ApiRoute.capture
            |> ApiRoute.slash
            |> ApiRoute.literal ".json"
            |> ApiRoute.preRender
                (\route ->
                    BackendTask.succeed
                        [ route "dillonkearns" "elm-graphql"
                        , route "dillonkearns" "elm-pages"
                        ]
                )

You can view these files in the dev server at <http://localhost:1234/repo/dillonkearns/elm-graphql.json>, and when you run `elm-pages build` this will result in the following files being generated:

  - `dist/repo/dillonkearns/elm-graphql.json`
  - `dist/repo/dillonkearns/elm-pages.json`

Note: `dist` is the output folder for `elm-pages build`, so this will be accessible in your hosted site at `/repo/dillonkearns/elm-graphql.json` and `/repo/dillonkearns/elm-pages.json`.

preRender: 
    (constructor
    -> BackendTask.BackendTask FatalError.FatalError (List (List String)))
    -> ApiRoute.ApiRouteBuilder (BackendTask.BackendTask FatalError.FatalError String) constructor
    -> ApiRoute.ApiRoute ApiRoute.Response
-}
preRender :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
preRender preRenderArg preRenderArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "preRender"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "constructor" ]
                            (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.list (Type.list Type.string)
                                ]
                            )
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.string
                                ]
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "preRenderUnpack" preRenderArg, preRenderArg0 ]


{-| serverRender: 
    ApiRoute.ApiRouteBuilder (Server.Request.Request
    -> BackendTask.BackendTask FatalError.FatalError (Server.Response.Response Basics.Never Basics.Never)) constructor
    -> ApiRoute.ApiRoute ApiRoute.Response
-}
serverRender : Elm.Expression -> Elm.Expression
serverRender serverRenderArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "serverRender"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.function
                                [ Type.namedWith
                                    [ "Server", "Request" ]
                                    "Request"
                                    []
                                ]
                                (Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    , Type.namedWith
                                        [ "Server", "Response" ]
                                        "Response"
                                        [ Type.namedWith [ "Basics" ] "Never" []
                                        , Type.namedWith [ "Basics" ] "Never" []
                                        ]
                                    ]
                                )
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
        )
        [ serverRenderArg ]


{-| preRenderWithFallback: 
    (constructor
    -> BackendTask.BackendTask FatalError.FatalError (List (List String)))
    -> ApiRoute.ApiRouteBuilder (BackendTask.BackendTask FatalError.FatalError (Server.Response.Response Basics.Never Basics.Never)) constructor
    -> ApiRoute.ApiRoute ApiRoute.Response
-}
preRenderWithFallback :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
preRenderWithFallback preRenderWithFallbackArg preRenderWithFallbackArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "preRenderWithFallback"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "constructor" ]
                            (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.list (Type.list Type.string)
                                ]
                            )
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.namedWith
                                    [ "Server", "Response" ]
                                    "Response"
                                    [ Type.namedWith [ "Basics" ] "Never" []
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    ]
                                ]
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "preRenderWithFallbackUnpack"
            preRenderWithFallbackArg
        , preRenderWithFallbackArg0
        ]


{-| Captures a dynamic segment from the route.

capture: 
    ApiRoute.ApiRouteBuilder (String -> a) constructor
    -> ApiRoute.ApiRouteBuilder a (String -> constructor)
-}
capture : Elm.Expression -> Elm.Expression
capture captureArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "capture"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.function [ Type.string ] (Type.var "a")
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a"
                            , Type.function
                                [ Type.string ]
                                (Type.var "constructor")
                            ]
                        )
                    )
            }
        )
        [ captureArg ]


{-| A literal String segment of a route.

literal: 
    String
    -> ApiRoute.ApiRouteBuilder a constructor
    -> ApiRoute.ApiRouteBuilder a constructor
-}
literal : String -> Elm.Expression -> Elm.Expression
literal literalArg literalArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "literal"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        )
                    )
            }
        )
        [ Elm.string literalArg, literalArg0 ]


{-| A path separator within the route.

slash: ApiRoute.ApiRouteBuilder a constructor -> ApiRoute.ApiRouteBuilder a constructor
-}
slash : Elm.Expression -> Elm.Expression
slash slashArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        )
                    )
            }
        )
        [ slashArg ]


{-| Starts the definition of a route with any captured segments.

succeed: a -> ApiRoute.ApiRouteBuilder a (List String)
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.list Type.string ]
                        )
                    )
            }
        )
        [ succeedArg ]


{-| Include head tags on every page's HTML.

withGlobalHeadTags: 
    BackendTask.BackendTask FatalError.FatalError (List Head.Tag)
    -> ApiRoute.ApiRoute response
    -> ApiRoute.ApiRoute response
-}
withGlobalHeadTags : Elm.Expression -> Elm.Expression -> Elm.Expression
withGlobalHeadTags withGlobalHeadTagsArg withGlobalHeadTagsArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "withGlobalHeadTags"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "BackendTask" ]
                            "BackendTask"
                            [ Type.namedWith [ "FatalError" ] "FatalError" []
                            , Type.list (Type.namedWith [ "Head" ] "Tag" [])
                            ]
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        )
                    )
            }
        )
        [ withGlobalHeadTagsArg, withGlobalHeadTagsArg0 ]


{-| Turn the route into a pattern in JSON format. For internal uses.

toJson: ApiRoute.ApiRoute response -> Json.Encode.Value
-}
toJson : Elm.Expression -> Elm.Expression
toJson toJsonArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "toJson"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
        )
        [ toJsonArg ]


{-| For internal use by generated code. Not so useful in user-land.

getBuildTimeRoutes: 
    ApiRoute.ApiRoute response
    -> BackendTask.BackendTask FatalError.FatalError (List String)
-}
getBuildTimeRoutes : Elm.Expression -> Elm.Expression
getBuildTimeRoutes getBuildTimeRoutesArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "getBuildTimeRoutes"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.namedWith
                            [ "BackendTask" ]
                            "BackendTask"
                            [ Type.namedWith [ "FatalError" ] "FatalError" []
                            , Type.list Type.string
                            ]
                        )
                    )
            }
        )
        [ getBuildTimeRoutesArg ]


{-| For internal use.

getGlobalHeadTagsBackendTask: 
    ApiRoute.ApiRoute response
    -> Maybe (BackendTask.BackendTask FatalError.FatalError (List Head.Tag))
-}
getGlobalHeadTagsBackendTask : Elm.Expression -> Elm.Expression
getGlobalHeadTagsBackendTask getGlobalHeadTagsBackendTaskArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "getGlobalHeadTagsBackendTask"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.maybe
                            (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.list (Type.namedWith [ "Head" ] "Tag" [])
                                ]
                            )
                        )
                    )
            }
        )
        [ getGlobalHeadTagsBackendTaskArg ]


annotation_ :
    { apiRoute : Type.Annotation -> Type.Annotation
    , apiRouteBuilder : Type.Annotation -> Type.Annotation -> Type.Annotation
    , response : Type.Annotation
    }
annotation_ =
    { apiRoute =
        \apiRouteArg0 ->
            Type.alias
                moduleName_
                "ApiRoute"
                [ apiRouteArg0 ]
                (Type.namedWith
                    [ "Internal", "ApiRoute" ]
                    "ApiRoute"
                    [ Type.var "response" ]
                )
    , apiRouteBuilder =
        \apiRouteBuilderArg0 apiRouteBuilderArg1 ->
            Type.alias
                moduleName_
                "ApiRouteBuilder"
                [ apiRouteBuilderArg0, apiRouteBuilderArg1 ]
                (Type.namedWith
                    [ "Internal", "ApiRoute" ]
                    "ApiRouteBuilder"
                    [ Type.var "a", Type.var "constructor" ]
                )
    , response =
        Type.alias
            moduleName_
            "Response"
            []
            (Type.namedWith [ "Json", "Encode" ] "Value" [])
    }


call_ :
    { single : Elm.Expression -> Elm.Expression
    , preRender : Elm.Expression -> Elm.Expression -> Elm.Expression
    , serverRender : Elm.Expression -> Elm.Expression
    , preRenderWithFallback : Elm.Expression -> Elm.Expression -> Elm.Expression
    , capture : Elm.Expression -> Elm.Expression
    , literal : Elm.Expression -> Elm.Expression -> Elm.Expression
    , slash : Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , withGlobalHeadTags : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toJson : Elm.Expression -> Elm.Expression
    , getBuildTimeRoutes : Elm.Expression -> Elm.Expression
    , getGlobalHeadTagsBackendTask : Elm.Expression -> Elm.Expression
    }
call_ =
    { single =
        \singleArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "single"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                        , Type.string
                                        ]
                                    , Type.list Type.string
                                    ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.namedWith
                                        [ "ApiRoute" ]
                                        "Response"
                                        []
                                    ]
                                )
                            )
                    }
                )
                [ singleArg ]
    , preRender =
        \preRenderArg preRenderArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "preRender"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "constructor" ]
                                    (Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                        , Type.list (Type.list Type.string)
                                        ]
                                    )
                                , Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                        , Type.string
                                        ]
                                    , Type.var "constructor"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.namedWith
                                        [ "ApiRoute" ]
                                        "Response"
                                        []
                                    ]
                                )
                            )
                    }
                )
                [ preRenderArg, preRenderArg0 ]
    , serverRender =
        \serverRenderArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "serverRender"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.function
                                        [ Type.namedWith
                                            [ "Server", "Request" ]
                                            "Request"
                                            []
                                        ]
                                        (Type.namedWith
                                            [ "BackendTask" ]
                                            "BackendTask"
                                            [ Type.namedWith
                                                [ "FatalError" ]
                                                "FatalError"
                                                []
                                            , Type.namedWith
                                                [ "Server", "Response" ]
                                                "Response"
                                                [ Type.namedWith
                                                    [ "Basics" ]
                                                    "Never"
                                                    []
                                                , Type.namedWith
                                                    [ "Basics" ]
                                                    "Never"
                                                    []
                                                ]
                                            ]
                                        )
                                    , Type.var "constructor"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.namedWith
                                        [ "ApiRoute" ]
                                        "Response"
                                        []
                                    ]
                                )
                            )
                    }
                )
                [ serverRenderArg ]
    , preRenderWithFallback =
        \preRenderWithFallbackArg preRenderWithFallbackArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "preRenderWithFallback"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "constructor" ]
                                    (Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                        , Type.list (Type.list Type.string)
                                        ]
                                    )
                                , Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                        , Type.namedWith
                                            [ "Server", "Response" ]
                                            "Response"
                                            [ Type.namedWith
                                                [ "Basics" ]
                                                "Never"
                                                []
                                            , Type.namedWith
                                                [ "Basics" ]
                                                "Never"
                                                []
                                            ]
                                        ]
                                    , Type.var "constructor"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.namedWith
                                        [ "ApiRoute" ]
                                        "Response"
                                        []
                                    ]
                                )
                            )
                    }
                )
                [ preRenderWithFallbackArg, preRenderWithFallbackArg0 ]
    , capture =
        \captureArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "capture"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.function
                                        [ Type.string ]
                                        (Type.var "a")
                                    , Type.var "constructor"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.var "a"
                                    , Type.function
                                        [ Type.string ]
                                        (Type.var "constructor")
                                    ]
                                )
                            )
                    }
                )
                [ captureArg ]
    , literal =
        \literalArg literalArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "literal"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.var "a", Type.var "constructor" ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.var "a", Type.var "constructor" ]
                                )
                            )
                    }
                )
                [ literalArg, literalArg0 ]
    , slash =
        \slashArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "slash"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.var "a", Type.var "constructor" ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.var "a", Type.var "constructor" ]
                                )
                            )
                    }
                )
                [ slashArg ]
    , succeed =
        \succeedArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "succeed"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRouteBuilder"
                                    [ Type.var "a", Type.list Type.string ]
                                )
                            )
                    }
                )
                [ succeedArg ]
    , withGlobalHeadTags =
        \withGlobalHeadTagsArg withGlobalHeadTagsArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "withGlobalHeadTags"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    , Type.list
                                        (Type.namedWith [ "Head" ] "Tag" [])
                                    ]
                                , Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.var "response" ]
                                ]
                                (Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.var "response" ]
                                )
                            )
                    }
                )
                [ withGlobalHeadTagsArg, withGlobalHeadTagsArg0 ]
    , toJson =
        \toJsonArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "toJson"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.var "response" ]
                                ]
                                (Type.namedWith [ "Json", "Encode" ] "Value" [])
                            )
                    }
                )
                [ toJsonArg ]
    , getBuildTimeRoutes =
        \getBuildTimeRoutesArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "getBuildTimeRoutes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.var "response" ]
                                ]
                                (Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    , Type.list Type.string
                                    ]
                                )
                            )
                    }
                )
                [ getBuildTimeRoutesArg ]
    , getGlobalHeadTagsBackendTask =
        \getGlobalHeadTagsBackendTaskArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ApiRoute" ]
                    , name = "getGlobalHeadTagsBackendTask"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "ApiRoute" ]
                                    "ApiRoute"
                                    [ Type.var "response" ]
                                ]
                                (Type.maybe
                                    (Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                        , Type.list
                                            (Type.namedWith [ "Head" ] "Tag" [])
                                        ]
                                    )
                                )
                            )
                    }
                )
                [ getGlobalHeadTagsBackendTaskArg ]
    }


values_ :
    { single : Elm.Expression
    , preRender : Elm.Expression
    , serverRender : Elm.Expression
    , preRenderWithFallback : Elm.Expression
    , capture : Elm.Expression
    , literal : Elm.Expression
    , slash : Elm.Expression
    , succeed : Elm.Expression
    , withGlobalHeadTags : Elm.Expression
    , toJson : Elm.Expression
    , getBuildTimeRoutes : Elm.Expression
    , getGlobalHeadTagsBackendTask : Elm.Expression
    }
values_ =
    { single =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "single"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.string
                                ]
                            , Type.list Type.string
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
    , preRender =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "preRender"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "constructor" ]
                            (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.list (Type.list Type.string)
                                ]
                            )
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.string
                                ]
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
    , serverRender =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "serverRender"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.function
                                [ Type.namedWith
                                    [ "Server", "Request" ]
                                    "Request"
                                    []
                                ]
                                (Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    , Type.namedWith
                                        [ "Server", "Response" ]
                                        "Response"
                                        [ Type.namedWith [ "Basics" ] "Never" []
                                        , Type.namedWith [ "Basics" ] "Never" []
                                        ]
                                    ]
                                )
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
    , preRenderWithFallback =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "preRenderWithFallback"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "constructor" ]
                            (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.list (Type.list Type.string)
                                ]
                            )
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.namedWith
                                    [ "Server", "Response" ]
                                    "Response"
                                    [ Type.namedWith [ "Basics" ] "Never" []
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    ]
                                ]
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                        )
                    )
            }
    , capture =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "capture"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.function [ Type.string ] (Type.var "a")
                            , Type.var "constructor"
                            ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a"
                            , Type.function
                                [ Type.string ]
                                (Type.var "constructor")
                            ]
                        )
                    )
            }
    , literal =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "literal"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        )
                    )
            }
    , slash =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.var "constructor" ]
                        )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRouteBuilder"
                            [ Type.var "a", Type.list Type.string ]
                        )
                    )
            }
    , withGlobalHeadTags =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "withGlobalHeadTags"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "BackendTask" ]
                            "BackendTask"
                            [ Type.namedWith [ "FatalError" ] "FatalError" []
                            , Type.list (Type.namedWith [ "Head" ] "Tag" [])
                            ]
                        , Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        )
                    )
            }
    , toJson =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "toJson"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    , getBuildTimeRoutes =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "getBuildTimeRoutes"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.namedWith
                            [ "BackendTask" ]
                            "BackendTask"
                            [ Type.namedWith [ "FatalError" ] "FatalError" []
                            , Type.list Type.string
                            ]
                        )
                    )
            }
    , getGlobalHeadTagsBackendTask =
        Elm.value
            { importFrom = [ "ApiRoute" ]
            , name = "getGlobalHeadTagsBackendTask"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "ApiRoute" ]
                            "ApiRoute"
                            [ Type.var "response" ]
                        ]
                        (Type.maybe
                            (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                    [ "FatalError" ]
                                    "FatalError"
                                    []
                                , Type.list (Type.namedWith [ "Head" ] "Tag" [])
                                ]
                            )
                        )
                    )
            }
    }


