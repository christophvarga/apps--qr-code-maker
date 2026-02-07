# Test Report - QR Code Maker

## Uebersicht

| Metrik | Wert |
|--------|------|
| Datum | 07.02.2026 |
| Suite | Playwright E2E |
| Browser | Chromium |
| Passed | 47 |
| Failed | 0 |
| Skipped | 0 |
| Laufzeit | 36.72s |

## Test Kategorien

### TestPageLoad (9 Tests)
- test_page_title - PASSED
- test_heading_visible - PASSED
- test_subtitle_visible - PASSED
- test_tabs_present - PASSED
- test_text_tab_active_by_default - PASSED
- test_generate_button_visible - PASSED
- test_download_button_hidden_initially - PASSED
- test_error_message_hidden_initially - PASSED
- test_noscript_not_visible - PASSED

### TestTabNavigation (4 Tests)
- test_switch_to_wifi_tab - PASSED
- test_switch_to_design_tab - PASSED
- test_switch_back_to_text_tab - PASSED
- test_only_one_tab_active - PASSED

### TestAccessibility (11 Tests)
- test_tablist_role - PASSED
- test_tab_roles - PASSED
- test_tabpanel_roles - PASSED
- test_aria_selected_on_active_tab - PASSED
- test_aria_selected_updates_on_switch - PASSED
- test_aria_controls_present - PASSED
- test_keyboard_arrow_right_navigation - PASSED
- test_keyboard_arrow_left_wraps - PASSED
- test_error_message_has_alert_role - PASSED
- test_canvas_has_aria_label - PASSED

### TestTextURLQRCode (6 Tests)
- test_generate_url_qr_code - PASSED
- test_generate_text_qr_code - PASSED
- test_empty_text_shows_inline_error - PASSED
- test_download_button_appears_after_generation - PASSED
- test_enter_key_generates_qr - PASSED
- test_error_clears_on_successful_generation - PASSED

### TestWLANQRCode (6 Tests)
- test_wifi_form_elements_present - PASSED
- test_generate_wifi_qr_code - PASSED
- test_empty_ssid_shows_inline_error - PASSED
- test_wifi_security_options - PASSED
- test_wifi_without_password - PASSED
- test_wifi_special_chars_in_ssid - PASSED

### TestDesignOptions (4 Tests)
- test_color_pickers_present - PASSED
- test_gradient_checkbox - PASSED
- test_logo_size_slider - PASSED
- test_custom_colors_applied - PASSED

### TestAdvancedSettings (6 Tests)
- test_ecc_level_options - PASSED
- test_ecc_default_value - PASSED
- test_pixel_size_options - PASSED
- test_pixel_size_default_value - PASSED
- test_change_ecc_level - PASSED
- test_change_output_size - PASSED

### TestQRCodeRegeneration (2 Tests)
- test_regenerate_with_different_text - PASSED
- test_switch_from_text_to_wifi - PASSED
