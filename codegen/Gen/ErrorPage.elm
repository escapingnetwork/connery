module Gen.ErrorPage exposing (annotation_, call_, caseOf_, init, internalError, make_, moduleName_, notFound, statusCode, update, values_, view)

{-| 
@docs values_, call_, caseOf_, make_, annotation_, init, update, notFound, internalError, view, statusCode, moduleName_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "ErrorPage" ]


{-| statusCode: ErrorPage -> number -}
statusCode : Elm.Expression -> Elm.Expression
statusCode statusCodeArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "statusCode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" [] ]
                        (Type.var "number")
                    )
            }
        )
        [ statusCodeArg ]


{-| view: ErrorPage -> Model -> View Msg -}
view : Elm.Expression -> Elm.Expression -> Elm.Expression
view viewArg viewArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "view"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" []
                        , Type.namedWith [] "Model" []
                        ]
                        (Type.namedWith [] "View" [ Type.namedWith [] "Msg" [] ]
                        )
                    )
            }
        )
        [ viewArg, viewArg0 ]


{-| internalError: String -> ErrorPage -}
internalError : String -> Elm.Expression
internalError internalErrorArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "internalError"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [] "ErrorPage" [])
                    )
            }
        )
        [ Elm.string internalErrorArg ]


{-| notFound: ErrorPage -}
notFound : Elm.Expression
notFound =
    Elm.value
        { importFrom = [ "ErrorPage" ]
        , name = "notFound"
        , annotation = Just (Type.namedWith [] "ErrorPage" [])
        }


{-| update: ErrorPage -> Msg -> Model -> ( Model, Effect Msg ) -}
update : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg updateArg0 updateArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" []
                        , Type.namedWith [] "Msg" []
                        , Type.namedWith [] "Model" []
                        ]
                        (Type.tuple
                            (Type.namedWith [] "Model" [])
                            (Type.namedWith
                                []
                                "Effect"
                                [ Type.namedWith [] "Msg" [] ]
                            )
                        )
                    )
            }
        )
        [ updateArg, updateArg0, updateArg1 ]


{-| init: ErrorPage -> ( Model, Effect Msg ) -}
init : Elm.Expression -> Elm.Expression
init initArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" [] ]
                        (Type.tuple
                            (Type.namedWith [] "Model" [])
                            (Type.namedWith
                                []
                                "Effect"
                                [ Type.namedWith [] "Msg" [] ]
                            )
                        )
                    )
            }
        )
        [ initArg ]


annotation_ :
    { model : Type.Annotation
    , errorPage : Type.Annotation
    , msg : Type.Annotation
    }
annotation_ =
    { model = Type.alias moduleName_ "Model" [] (Type.record [])
    , errorPage = Type.namedWith [ "ErrorPage" ] "ErrorPage" []
    , msg = Type.namedWith [ "ErrorPage" ] "Msg" []
    }


make_ :
    { model : model -> Elm.Expression
    , notFound : Elm.Expression
    , internalError : Elm.Expression -> Elm.Expression
    }
make_ =
    { model =
        \model_args ->
            Elm.withType
                (Type.alias [ "ErrorPage" ] "Model" [] (Type.record []))
                (Elm.record [])
    , notFound =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "NotFound"
            , annotation = Just (Type.namedWith [] "ErrorPage" [])
            }
    , internalError =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ErrorPage" ]
                    , name = "InternalError"
                    , annotation = Just (Type.namedWith [] "ErrorPage" [])
                    }
                )
                [ ar0 ]
    }


caseOf_ :
    { errorPage :
        Elm.Expression
        -> { errorPageTags_0_0
            | notFound : Elm.Expression
            , internalError : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { errorPage =
        \errorPageExpression errorPageTags ->
            Elm.Case.custom
                errorPageExpression
                (Type.namedWith [ "ErrorPage" ] "ErrorPage" [])
                [ Elm.Case.branch0 "NotFound" errorPageTags.notFound
                , Elm.Case.branch1
                    "InternalError"
                    ( "string.String", Type.string )
                    errorPageTags.internalError
                ]
    }


call_ :
    { statusCode : Elm.Expression -> Elm.Expression
    , view : Elm.Expression -> Elm.Expression -> Elm.Expression
    , internalError : Elm.Expression -> Elm.Expression
    , update :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , init : Elm.Expression -> Elm.Expression
    }
call_ =
    { statusCode =
        \statusCodeArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ErrorPage" ]
                    , name = "statusCode"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [] "ErrorPage" [] ]
                                (Type.var "number")
                            )
                    }
                )
                [ statusCodeArg ]
    , view =
        \viewArg viewArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ErrorPage" ]
                    , name = "view"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [] "ErrorPage" []
                                , Type.namedWith [] "Model" []
                                ]
                                (Type.namedWith
                                    []
                                    "View"
                                    [ Type.namedWith [] "Msg" [] ]
                                )
                            )
                    }
                )
                [ viewArg, viewArg0 ]
    , internalError =
        \internalErrorArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ErrorPage" ]
                    , name = "internalError"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [] "ErrorPage" [])
                            )
                    }
                )
                [ internalErrorArg ]
    , update =
        \updateArg updateArg0 updateArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ErrorPage" ]
                    , name = "update"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [] "ErrorPage" []
                                , Type.namedWith [] "Msg" []
                                , Type.namedWith [] "Model" []
                                ]
                                (Type.tuple
                                    (Type.namedWith [] "Model" [])
                                    (Type.namedWith
                                        []
                                        "Effect"
                                        [ Type.namedWith [] "Msg" [] ]
                                    )
                                )
                            )
                    }
                )
                [ updateArg, updateArg0, updateArg1 ]
    , init =
        \initArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "ErrorPage" ]
                    , name = "init"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [] "ErrorPage" [] ]
                                (Type.tuple
                                    (Type.namedWith [] "Model" [])
                                    (Type.namedWith
                                        []
                                        "Effect"
                                        [ Type.namedWith [] "Msg" [] ]
                                    )
                                )
                            )
                    }
                )
                [ initArg ]
    }


values_ :
    { statusCode : Elm.Expression
    , view : Elm.Expression
    , internalError : Elm.Expression
    , notFound : Elm.Expression
    , update : Elm.Expression
    , init : Elm.Expression
    }
values_ =
    { statusCode =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "statusCode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" [] ]
                        (Type.var "number")
                    )
            }
    , view =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "view"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" []
                        , Type.namedWith [] "Model" []
                        ]
                        (Type.namedWith [] "View" [ Type.namedWith [] "Msg" [] ]
                        )
                    )
            }
    , internalError =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "internalError"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [] "ErrorPage" [])
                    )
            }
    , notFound =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "notFound"
            , annotation = Just (Type.namedWith [] "ErrorPage" [])
            }
    , update =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" []
                        , Type.namedWith [] "Msg" []
                        , Type.namedWith [] "Model" []
                        ]
                        (Type.tuple
                            (Type.namedWith [] "Model" [])
                            (Type.namedWith
                                []
                                "Effect"
                                [ Type.namedWith [] "Msg" [] ]
                            )
                        )
                    )
            }
    , init =
        Elm.value
            { importFrom = [ "ErrorPage" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [] "ErrorPage" [] ]
                        (Type.tuple
                            (Type.namedWith [] "Model" [])
                            (Type.namedWith
                                []
                                "Effect"
                                [ Type.namedWith [] "Msg" [] ]
                            )
                        )
                    )
            }
    }


