# API Error Codes — Contract for All Clients

> Canonical reference for the RTC API error contract. Implemented by the backend
> (`apps/core/error_codes.py`), the Angular web app, and the Flutter mobile app.
> Backend copy stays **English**; each client maps `code` → a localized (Persian)
> message and decides how much to explain.

## Error envelope

Every error response uses this exact shape:

```json
{
  "error": {
    "status_code": 422,
    "code": "tolerance_exceeded",
    "params": { "variance": 15.5, "tolerance": 10 },
    "detail": "Variance 15.50% exceeds agent tolerance 10%."
  }
}
```

| Field | Meaning |
|---|---|
| `status_code` | HTTP status (mirrors the response status). |
| `code` | **Stable machine identifier.** The key clients localize on. Never renamed without updating this doc + all clients. |
| `params` | Structured values for message interpolation. May be `{}`. |
| `detail` | English text for **logs/debugging only**. Clients must **not** show this to end users. |

For **400 validation errors**, `detail` is a field map (`{ "mobile": ["..."] }`) and
`code` is `validation_error`.

## Client rules (web + mobile)

1. Read **`error.code`** first; look it up in the local `code → message` map.
2. Interpolate **`error.params`** into the chosen message where relevant.
3. Each client **decides verbosity per code** (column below is advisory): show a
   short generic line for `terse` codes, an explanatory line for `detailed` codes.
4. For an **unknown code**, fall back to a generic localized message
   (e.g. «خطایی رخ داد، دوباره تلاش کنید»). **Never** display `error.detail`.
5. `network_error` is a client-only code for transport failures (HTTP status `0`).

## Catalog

| code | HTTP | params | verbosity | raised when |
|---|---|---|---|---|
| `validation_error` | 400 | — (`detail` is a field map) | detailed (per field) | serializer field validation failed |
| `not_authenticated` | 401 | — | terse | missing/invalid credentials |
| `permission_denied` | 403 | — | terse | role not allowed |
| `not_found` | 404 | — | terse | resource missing |
| `method_not_allowed` | 405 | — | terse | HTTP method not allowed |
| `rate_limited` | 429 | — | terse | throttled |
| `server_error` | 500 | — | terse | unexpected server failure |
| `otp_expired` | 422 | — | terse | OTP missing/expired in store |
| `otp_invalid` | 422 | — | detailed | OTP code does not match |
| `otp_rate_limited` | 429 | — | terse | too many OTP requests |
| `user_not_registered` | 404 | — | detailed | mobile not registered |
| `tolerance_exceeded` | 422 | `variance:number`, `tolerance:number` | detailed | disbursement variance over agent tolerance |
| `credit_limit_exceeded` | 422 | `debit:int`, `resulting_balance:int`, `credit_limit:int` | detailed | debit would breach credit limit |
| `insufficient_pocket_balance` | 422 | — | detailed | pocket lacks balance for debit |
| `product_not_available_for_subplan` | 422 | — | detailed | product not orderable under the sub-plan |
| `insufficient_stock` | 422 | — | detailed | ordered qty exceeds stock |
| `illegal_state_transition` | 422 | — | terse | order state transition not allowed |
| `order_immutable` | 422 | — | terse | editing a rejected/locked order |
| `invalid_order_status` | 422 | — | detailed | operation not valid for current status |
| `order_not_editable` | 422 | — | detailed | order edited outside `pre_invoice` |
| `order_total_limit_exceeded` | 422 | `order_total:int`, `max_total:int` | detailed | order total exceeds the configured maximum |
| `agent_required` | 400 | — | detailed | staff created an order without an agent |
| `pre_invoice_unavailable` | 422 | — | terse | pre-invoice requested for non-pre-invoice order |
| `sales_queue_empty` | 404 | — | detailed | no unassigned orders to pick |
| `not_assigned_sales_reviewer` | 403 | — | detailed | not the assigned sales reviewer |
| `not_assigned_finance_reviewer` | 403 | — | detailed | not the assigned finance reviewer |
| `gateway_invalid_otp` | 400 | — | detailed | bank OTP wrong (retry confirm) |
| `gateway_session_expired` | 400 | — | detailed | gateway session expired (re-initiate) |
| `gateway_rejected` | 400 | — | detailed | bank rejected the transaction |
| `gateway_unavailable` | 502 | — | terse | gateway temporarily unreachable (retry) |
| `gateway_misconfigured` | 422 | — | terse | no active IPG / unknown gateway type |
| `subplan_has_orders` | 400 | — | detailed | sub-plan delete blocked by orders |
| `subplan_has_transactions` | 400 | — | detailed | sub-plan delete blocked by pocket transactions |
| `category_has_products` | 409 | — | detailed | category delete blocked by products |
| `product_not_orderable` | 422 | — | detailed | product not orderable under sub-plan (catalog) |
| `unsupported_file_type` | 422 | — | detailed | upload MIME/extension not allowed |
| `file_too_large` | 422 | `max_mb:number` | detailed | upload exceeds size limit |
| `image_processing_failed` | 422 | — | terse | image could not be processed |
| `file_processing_failed` | 422 | — | terse | file could not be processed |
| `network_error` | 0 (client) | — | terse | transport/CORS failure (client-generated) |

## Adding a new code

1. Add the constant to `apps/core/error_codes.py`.
2. Set `code` (+ `status_code`) on the raising exception, or pass it to `api_error(...)`.
3. Add a row here.
4. Add the localized entry in each client's `code → message` map.

Until a client ships the new entry, its generic fallback (rule 4) handles it safely.
