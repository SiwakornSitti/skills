# Classification and PII

- Classify fields at collection and trust boundaries. Classification depends on linkability and context: a field that is harmless alone can become PII when combined with another field.
- Validate, authorize, and collect only what the use case needs. Treat unclassified dynamic JSON fields as sensitive until reviewed.
- Never log raw PII, financial, health, authentication, or validator input. Allowlist non-sensitive event fields and redact before logging.
- Separate internal and public representations. Exclude sensitive fields from serialization where supported, but do not treat that guard as authorization.
- Return only required fields; use opaque IDs across service and queue boundaries; avoid sensitive values in URLs, cache keys, or event names. Send sensitive headers only when required and protect them as secrets.
- For JSON objects, validate against a schema, reject unknown fields when shape is known, and treat dynamic fields as sensitive until classified.

## Common PII classes

- Direct identifiers: names, email addresses, phone numbers, national IDs, passport numbers, account numbers, and customer IDs.
- Quasi-identifiers: birth dates, home or billing addresses, postal codes, precise location, IP addresses, device IDs, and combinations such as age plus district.
- Financial data: credit-card numbers, card expiry and security codes, bank details, transaction history, and payment tokens.
- Health and biometric data: diagnoses, prescriptions, medical records, biometric templates, and face or voice data.
- Linkable pseudonyms: opaque customer, session, or device IDs are still personal data when they can be linked to a person.

## Example classification

```json
{
  "direct_identifier": "user@example.invalid",
  "quasi_identifier": {
    "birth_date": "2000-01-01",
    "postal_code": "00000",
    "ip_address": "192.0.2.10"
  },
  "financial": {
    "card_number": "<redacted>",
    "card_last4": "0000",
    "payment_token": "tok_test_001"
  },
  "linkable_id": "cust_test_001"
}
```

The categories are handling signals, not authorization decisions. A field may belong to more than one category.

## Safe fixture

```json
{
  "customer_id": "cust_test_001",
  "name": "Test User",
  "email": "user@example.invalid",
  "phone": "+66000000000",
  "national_id": "0000000000000",
  "birth_date": "2000-01-01",
  "address": {
    "line1": "<redacted>",
    "city": "Example City",
    "postal_code": "00000"
  },
  "device_id": "device_test_001"
}
```

When name is required by the client, return only the needed fields:

```json
{"customer_id":"cust_test_001","display_name":"Test User"}
```

Credit-card and address data need stricter minimization:

```json
{
  "card_number": "<redacted>",
  "billing_address": {
    "line1": "<redacted>",
    "city": "Example City",
    "postal_code": "00000"
  }
}
```

Store or return only required values, such as a payment token or card last four digits. Treat last four digits as sensitive; never log the full card number or street address.
