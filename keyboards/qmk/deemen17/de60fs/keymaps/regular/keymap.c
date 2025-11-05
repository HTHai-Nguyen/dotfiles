/* Copyright 2023 Deemen17
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H

enum macros{
    MACRO_BTN = SAFE_RANGE
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case MACRO_BTN:
            if (record->event.pressed) {
                // Delay 20ms sau khi nhấn phím
                wait_ms(20);
                
                // Nhấn nút chuột phải
                register_code(KC_MS_BTN2);
                wait_ms(10);  // Thêm delay ngắn để đảm bảo click được ghi nhận
                unregister_code(KC_MS_BTN2);
            }
            return false;
        default:
            return true;
    }
}


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /*
     * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
     * │Esc│ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ - │ = │ ~ │Del│
     * ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴───┤
     * │ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │ [ │ ] │ Bsp │
     * ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤
     * │ Ctrl │ A │ S │ D │ F │ G │ H │ J │ K │ L │ ; │ ' │  Enter │
     * ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────┬───┤
     * │ Shift  │ Z │ X │ C │ V │ B │ N │ M │ , │ . │ / │ Shift│Fn │
     * ├─────┬──┴┬──┴──┬┴───┴───┴───┴───┴───┴───┴──┬┴───┴┬───┬─┴───┤
     * │Ctrl │GUI│ Alt │         Space             │ Alt │GUI│ Ctrl│
     * └─────┴───┴─────┴───────────────────────────┴─────┴───┴─────┘
     */
    [0] = LAYOUT_all(
        KC_ESC,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_GRV, KC_DEL,
        KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_QUOT, KC_LBRC, KC_RBRC, KC_BSPC,
        KC_LCTL, KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_P,    KC_SCLN,          KC_ENT,
        KC_LSFT,          KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT, KC_RSFT,
        KC_LCTL, KC_LGUI, KC_LALT,                            KC_SPC,                                      KC_LEFT, KC_DOWN, KC_RGHT
    ),

    [1] = LAYOUT_all(
        KC_GRV,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_GRV, KC_DEL,
        KC_CAPS, KC_HOME,    KC_UP,    KC_END,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_PAUS,    KC_LBRC, KC_RBRC, KC_BSLS,
        KC_TRNS, KC_LEFT,    KC_DOWN,    KC_RGHT,    KC_ENT,    KC_G,    KC_LEFT,    KC_DOWN,    KC_UP,    KC_RGHT,    KC_TRNS, KC_TRNS,          KC_ENT,
        KC_TRNS,          KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT, KC_TRNS,
        KC_TRNS, KC_LGUI, KC_LALT,                            KC_SPC,                                      KC_LEFT, KC_DOWN, KC_RGHT
    ),

    [2] = LAYOUT_all(
        KC_GRV,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_GRV, KC_DEL,
        KC_CAPS, KC_HOME,    KC_UP,    KC_END,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_PAUS,    KC_LBRC, KC_RBRC, KC_BSLS,
        KC_TRNS, KC_LEFT,    KC_DOWN,    KC_RGHT,    KC_ENT,    KC_G,    KC_LEFT,    KC_DOWN,    KC_UP,    KC_RGHT,    KC_TRNS, KC_TRNS,          KC_ENT,
        KC_TRNS,          KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT, KC_TRNS,
        KC_TRNS, KC_LGUI, KC_LALT,                            KC_SPC,                                      KC_LEFT, KC_DOWN, KC_RGHT
    ),

    [3] = LAYOUT_all(
        KC_GRV,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_GRV, KC_DEL,
        KC_CAPS, MACRO_BTN,   MACRO_BTN,   MACRO_BTN,    MACRO_BTN,    MACRO_BTN,    KC_TRNS,    KC_U,    KC_I,    KC_O,    KC_PAUS,    KC_LBRC, KC_RBRC, KC_BSLS,
        KC_TRNS, MACRO_BTN,   MACRO_BTN,   MACRO_BTN,    MACRO_BTN,    MACRO_BTN,    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS,    KC_TRNS, KC_TRNS,          KC_ENT,
        KC_TRNS,          KC_Z,    KC_X,    KC_C,    KC_V,    MACRO_BTN,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT, KC_TRNS,
        KC_TRNS, KC_LGUI, KC_LALT,                           MACRO_BTN,                                      KC_LEFT, KC_DOWN, KC_RGHT
    ),
};
