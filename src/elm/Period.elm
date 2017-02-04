module Period exposing (State, Period, PeriodError(..), toPeriod, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)


type alias State =
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


toPeriod : State -> Result PeriodError Period
toPeriod state =
    let
        age =
            String.toInt state.age

        expected =
            String.toInt state.expected
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


changeAge : (State -> msg) -> State -> String -> msg
changeAge toMsg state str =
    let
        state =
            { state | age = str }
    in
        toMsg state


changeExp : (State -> msg) -> State -> String -> msg
changeExp toMsg state str =
    let
        state =
            { state | expected = str }
    in
        toMsg state


view : (State -> msg) -> State -> Html msg
view onChange state =
    div []
        [ input
            [ placeholder "Age"
            , value state.age
            , onInput (changeAge onChange state)
            ]
            []
        , input
            [ placeholder "Expected"
            , value state.expected
            , onInput (changeExp onChange state)
            ]
            []
        ]
