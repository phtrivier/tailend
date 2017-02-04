module Period exposing (State, initState, stateToPeriod, Period, PeriodError(..), view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)


-- I leave the state 'opaque' by using a single constructor
-- enum type.


type State
    = State
        { age : String
        , expected : String
        }


initState : String -> String -> State
initState age expected =
    State { age = age, expected = expected }


type alias Period =
    { age : Int
    , expected : Int
    }


type PeriodError
    = InvalidValues
    | InvalidAge
    | InvalidExpected
    | InvalidRange


stateToPeriod : State -> Result PeriodError Period
stateToPeriod (State { age, expected }) =
    let
        age_ =
            String.toInt age

        expected_ =
            String.toInt expected
    in
        case ( age_, expected_ ) of
            ( Err _, Err _ ) ->
                Err InvalidValues

            ( Err _, _ ) ->
                Err InvalidAge

            ( _, Err _ ) ->
                Err InvalidExpected

            ( Ok age_, Ok expected_ ) ->
                if age_ <= expected_ then
                    Ok { age = age_, expected = expected_ }
                else
                    Err InvalidRange


changeAge : (State -> msg) -> State -> String -> msg
changeAge toMsg (State { age, expected }) str =
    let
        state =
            State { age = str, expected = expected }
    in
        toMsg state


changeExp : (State -> msg) -> State -> String -> msg
changeExp toMsg (State { age, expected }) str =
    let
        state =
            State { age = age, expected = str }
    in
        toMsg state


view : (State -> msg) -> State -> Html msg
view onChange ((State { age, expected }) as state) =
    div []
        [ input
            [ placeholder "Age"
            , value age
            , onInput (changeAge onChange state)
            ]
            []
        , input
            [ placeholder "Expected"
            , value expected
            , onInput (changeExp onChange state)
            ]
            []
        ]
