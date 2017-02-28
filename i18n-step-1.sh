pub run intl_translation:extract_to_arb --output-dir=translations/ `find lib -name *.dart`;
echo "Open generated translations/intl_messages.arb and add '_locale':'en_US' as the first field.";
