module Tailend exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- What are we talking about ?


type alias Model =
    { age : Int
    , expected : Int
    }



-- What can happen ? So far, just the start of the world.


type Msg
    = Start



-- Let's talk about a lucky 35 yo person, who expect to live up to 90.


initialModel : Model
initialModel =
    { age = 35
    , expected = 90
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )



-- We react to all messages but leaving the world intact, and doing nothing. Talk about a zen application.


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    ( model, Cmd.none )



-- We display things with simple images


view : Model -> Html Msg
view model =
    div [ class "page" ]
        [ tailendView model ]


tailendView : Model -> Html Msg
tailendView model =
    let
        crossed =
            model.age

        uncrossed =
            model.expected - model.age
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
