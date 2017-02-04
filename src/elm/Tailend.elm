module Tailend exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)


-- What are we talking about ?
-- type Error
--     = BadAge
--     | BadExpected


type alias Model =
    { age : Maybe Int
    , expected : Maybe Int
    }


type Msg
    = Start
    | ChangeAge String
    | ChangeExpected String


initialModel : Model
initialModel =
    { age = Just 35
    , expected = Just 90
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Start ->
            ( model, Cmd.none )

        ChangeAge age ->
            ( updateAge model age
            , Cmd.none
            )

        ChangeExpected expected ->
            ( updateExpected model expected, Cmd.none )


updateAge : Model -> String -> Model
updateAge model str =
    let
        age =
            str
                |> String.toInt
                |> Result.toMaybe
    in
        { model | age = age }


updateExpected : Model -> String -> Model
updateExpected model expected =
    case String.toInt expected of
        Ok expected ->
            { model | expected = Just expected }

        Err _ ->
            { model | expected = Nothing }


view : Model -> Html Msg
view model =
    div [ class "page" ]
        [ inputs model
        , tailendView model
        ]


inputs : Model -> Html Msg
inputs model =
    div []
        [ input
            [ placeholder "Age"
            , value (maybeToString model.age)
            , onInput ChangeAge
            ]
            []
        , input
            [ placeholder "Expected"
            , value (maybeToString model.expected)
            , onInput ChangeExpected
            ]
            []
        ]


maybeToString : Maybe Int -> String
maybeToString x =
    x
        |> Maybe.map toString
        |> Maybe.withDefault ""


handleAgeInput : String -> Msg
handleAgeInput =
    ChangeAge


tailendView : Model -> Html Msg
tailendView model =
    case ( model.age, model.expected ) of
        ( Nothing, _ ) ->
            div [] [ text "You should type an age" ]

        ( _, Nothing ) ->
            div [] [ text "You should type an expected age" ]

        ( Just age, Just expected ) ->
            let
                crossed =
                    age

                uncrossed =
                    expected - age
            in
                div [ class "tailend-view" ]
                    ((List.repeat crossed crossedItem) ++ (List.repeat uncrossed uncrossedItem))


crossedItem : Html Msg
crossedItem =
    div [ class "tailend-box" ]
        [ div [ class "tailend-cross" ]
            [ text "X" ]
        ]


uncrossedItem : Html Msg
uncrossedItem =
    div [ class "tailend-box" ]
        [ div [ class "tailend-item" ]
            [ text "O" ]
        ]
