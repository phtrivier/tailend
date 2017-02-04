module Tailend exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)


type alias Model =
    { age : String
    , expected : String
    }


type alias Period =
    { age : Int
    , expected : Int
    }


type PeriodError
    = InvalidValues
    | InvalidAge
    | InvalidExpected
    | InvalidRange


toPeriod : Model -> Result PeriodError Period
toPeriod model =
    let
        age =
            model.age
                |> String.toInt

        expected =
            model.expected
                |> String.toInt
    in
        case ( age, expected ) of
            ( Err _, Err _ ) ->
                Err InvalidValues

            ( Err _, _ ) ->
                Err InvalidAge

            ( _, Err _ ) ->
                Err InvalidExpected

            ( Ok age, Ok expected ) ->
                if age <= expected then
                    Ok { age = age, expected = expected }
                else
                    Err InvalidRange


initialModel : Model
initialModel =
    { age = "35"
    , expected = "90"
    }


type Msg
    = Start
    | ChangeAge String
    | ChangeExpected String


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

        ChangeAge a ->
            ( { model | age = a }, Cmd.none )

        ChangeExpected e ->
            ( { model | expected = e }, Cmd.none )


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
            , value model.age
            , onInput ChangeAge
            ]
            []
        , input
            [ placeholder "Expected"
            , value model.expected
            , onInput ChangeExpected
            ]
            []
        ]


tailendView : Model -> Html Msg
tailendView model =
    let
        period =
            toPeriod model
    in
        case period of
            Err e ->
                periodError e

            Ok p ->
                periodView p


periodView : Period -> Html Msg
periodView p =
    let
        crossed =
            p.age

        uncrossed =
            p.expected - p.age
    in
        div [ class "tailend-view" ]
            ((List.repeat crossed crossedItem) ++ (List.repeat uncrossed uncrossedItem))


periodError : PeriodError -> Html Msg
periodError error =
    let
        message =
            case error of
                InvalidValues ->
                    "Please type an age and expected age"

                InvalidAge ->
                    "Please type an age"

                InvalidExpected ->
                    "Please type an expected age"

                InvalidRange ->
                    "Your expected age should be bigger than your age"
    in
        div [] [ text message ]


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
