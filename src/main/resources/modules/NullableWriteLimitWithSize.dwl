import first from dw::core::Strings
import try from dw::Runtime

fun stringLimitWithSize(name, str, limit = 7000) = {
  (name): try(() -> str first limit).result,
  ("$(name)CharsCount"): try(() -> sizeOf(str as String)).result,
  ("$(name)BytesCount"): try(() -> sizeOf(str as Binary)).result,
  ("$(name)LimitCount"): limit as Number,
}

fun nullableWriteLimitWithSize(name, jsonable, limit = 7000) =
stringLimitWithSize(
  name,
  try(() -> write(jsonable, "json", {writeAttributes: true, duplicateKeyAsArray: true, indent: false, skipNullOn: "everywhere"}) first limit).result,
  limit
)
