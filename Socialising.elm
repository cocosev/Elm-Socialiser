module Socialising exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
  Html.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


type alias Model =
 {friends : Int , username : String, currentView : CurrentView}

model : Model
model =
  Model 0 "Cocosev" ViewCounter

init : ( Model, Cmd Msg )
init =
  (model, Cmd.none )

type Msg =
        Increment
        | Decrement

type CurrentView =
        ViewCounter
        | ViewMain

-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      if model.friends >= 15 then
        ( { model | currentView = ViewMain  } , Cmd.none )
      else
        ( { model | friends = model.friends + 1  } , Cmd.none )
    Decrement ->
      ( { model | friends =  model.friends - 1  } , Cmd.none )


-- functions to automatise stuff (not really necessary)

chooseWord : String -> String -> Int -> String
chooseWord singular plural howMany =
  if howMany == 1 then
    singular
  else
    plural


additionalInfo : Int -> Model -> String
additionalInfo howMany model =
  if howMany == 0 then
    model.username ++ " cannot lose any more friends."
  else if howMany < 10 then
    model.username ++ " doesn't have a lot of friends."
  else
    model.username ++ " is very popular!!"


-- VIEW

view : Model -> Html Msg
view model =
  case model.currentView of
    ViewMain ->
      viewMain model
    ViewCounter ->
      viewCounter model


viewCounter : Model -> Html Msg
viewCounter model =
    let
      isOff =
        model.friends <= 0

      caption = model.username ++ " has " ++ ( toString model.friends)
        ++ " " ++
        ( chooseWord "friend" "friends" model.friends )

    in
      div [ class "content", id "main body" ] [
        h1 [ style [ ("font-family" , "Arial"), ("text-align", "center")] ]
           [ text "Let's socialise !"]
        , div [style [("text-align", "center")]] [
            button
              [ onClick (Increment) ]
              [text "Befriend someone" ] ]
        , div [style [("text-align", "center")]] [
            button
              [  disabled isOff
              , onClick (Decrement)]
              [text "Engage in a fight"] ]
        , div [ style [ ("font-family" , "Verdana"), ("text-align", "center")]]
              [text caption]
        , div [ style [ ("font-family" , "Verdana"), ("text-align", "center")]]
              [ text (additionalInfo model.friends model)]
        ]
viewMain : Model -> Html Msg
viewMain model =
  div [myStyle][ text "I hope you enjoyed making friends :)"  ]



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- predefined style (note it is also a function)
myStyle =
  style
    [ ("width", "50%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    , ("font-family", "Verdana")
    ]
