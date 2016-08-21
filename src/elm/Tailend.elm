module Tailend exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

-- Numbers are running the world
type alias Model =
    Int

-- Our app does nothing but start
type Msg
    = Start

-- We start with a null model, and nothing to do next
init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )

-- We react to all messages but leaving the world intact, and doing nothing. Talk about a zen application.
update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    ( model, Cmd.none )

-- The simplest possible polite view.
view : Model -> Html Msg
view model =
    div []
        [ text "Hello world" ]
