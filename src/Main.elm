module Main exposing (main)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


headerView : Html msg
headerView =
    section
        [ id "header" ]
        []


bodyView : Html msg
bodyView =
    section
        [ id "body" ]
        [ h1
            [ css
                [ borderBottom2 (px 1) solid
                , color (hex "111")
                , margin2 (px 0) (px 25)
                , textAlign center
                ]
            ]
            [ text "Hi" ]
        , p
            [ css
                [ color (hex "222")
                , margin (px 25)
                ]
            ]
            [ text "My name is Heinrich." ]
        , p
            [ css
                [ color (hex "222")
                , margin (px 25)
                ]
            ]
            [ text "For now, this is just a playground." ]
        ]


footerView : Html msg
footerView =
    section
        [ id "footer" ]
        []


view : String -> Html msg
view _ =
    div
        [ css
            [ Css.width (pct 50)
            , Css.property "margin" "0 auto"
            ]
        ]
        [ headerView
        , bodyView
        , footerView
        ]


main =
    toUnstyled <| view ""
