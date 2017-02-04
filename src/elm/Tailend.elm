module Tailend exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- import Html.Events exposing (..)
-- import String exposing (..)

import Period exposing (..)


type alias Model =
    { periodState : Period.State
    }


initialModel : Model
initialModel =
    { periodState =
        { age = "35"
        , expected = "90"
        }
    }


type Msg
    = Start
    | SetPeriodState Period.State


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

        SetPeriodState s ->
            ( { model | periodState = s }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        onStateChange =
            SetPeriodState
    in
        div [ class "page" ]
            [ Period.view onStateChange model.periodState
            , tailendView model
            , div [] [ text model.periodState.age ]
            ]


tailendView : Model -> Html Msg
tailendView model =
    let
        period =
            toPeriod model.periodState
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
