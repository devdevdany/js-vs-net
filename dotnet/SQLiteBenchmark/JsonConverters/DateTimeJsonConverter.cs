using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace SQLiteBenchmark.JsonConverters;

internal sealed class DateTimeJsonConverter : JsonConverter<DateTime>
{
    public override DateTime Read(
        ref Utf8JsonReader reader,
        Type typeToConvert,
        JsonSerializerOptions options)
    {
        string? stringValue;
        try
        {
            stringValue = reader.GetString();
        }
        catch (InvalidOperationException)
        {
            throw new JsonException();
        }

        if (stringValue is null)
        {
            throw new JsonException();
        }

        var parseResult = DateTime.TryParseExact(stringValue, IsoDateTimeFormat.FormatString,
            CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime parsedDateTime);
        if (!parseResult)
        {
            throw new JsonException();
        }

        return parsedDateTime;
    }

    public override void Write(
        Utf8JsonWriter writer,
        DateTime value,
        JsonSerializerOptions options)
    {
        var asUtc = DateTime.SpecifyKind(value, DateTimeKind.Utc);
        var asString = asUtc.ToString(IsoDateTimeFormat.FormatString, CultureInfo.InvariantCulture);
        writer.WriteStringValue(asString);
    }
}
