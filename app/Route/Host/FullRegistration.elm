module Route.Host.FullRegistration exposing (..)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Content.Legals
import Effect
import ErrorPage
import FatalError exposing (FatalError)
import Head
import Html
import Html.Attributes as Attrs exposing (height)
import Layout.Legals
import PagesMsg
import RouteBuilder exposing (App, StatelessRoute)
import Server.Request
import Server.Response
import Shared
import UrlPath
import View


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


type alias Data =
    { legal : Content.Legals.Legal }


type alias ActionData =
    {}


data : BackendTask.BackendTask FatalError Data
data =
    Content.Legals.hosts
        |> BackendTask.allowFatal
        |> BackendTask.map Data


head : RouteBuilder.App Data ActionData RouteParams -> List Head.Tag
head app =
    []


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared =
    { title = "Irish Dream - Become A Host"
    , body =
        [ Html.div [ Attrs.class "mx-auto prose max-w-none pb-8 pt-8 dark:prose-invert xl:col-span-2 xl:max-w-5xl xl:px-0" ]
            [ Layout.Legals.view app.data.legal
            , Html.iframe
                [ Attrs.attribute "data-tally-src" "https://tally.so/embed/3xYZMG?alignLeft=0&hideTitle=1&transparentBackground=1&dynamicHeight=1"
                , Attrs.attribute "frameborder" "0"
                , Attrs.style "width" "100%"
                , Attrs.height 2400
                , Attrs.class "mx-auto prose dark:prose-invert xl:max-w-5xl xl:px-0"
                , Attrs.title "Become A Host"
                , Attrs.src "https://tally.so/embed/3xYZMG?alignLeft=0&hideTitle=1&transparentBackground=1&dynamicHeight=1"
                ]
                []
            ]
        ]
    }


action :
    RouteParams
    -> Server.Request.Request
    -> BackendTask.BackendTask FatalError.FatalError (Server.Response.Response ActionData ErrorPage.ErrorPage)
action routeParams request =
    BackendTask.succeed (Server.Response.render {})
