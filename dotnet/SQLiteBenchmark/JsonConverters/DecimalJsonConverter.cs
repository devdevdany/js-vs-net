using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace SQLiteBenchmark.JsonConverters;

internal sealed class DecimalJsonConverter : JsonConverter<decimal>
{
    public override decimal Read(
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

        var parseResult = decimal.TryParse(stringValue, NumberStyles.AllowLeadingSign | NumberStyles.AllowDecimalPoint,
            CultureInfo.InvariantCulture, out decimal parsedDecimal);
        if (!parseResult)
        {
            throw new JsonException();
        }

        return parsedDecimal;
    }

    public override void Write(
        Utf8JsonWriter writer,
        decimal value,
        JsonSerializerOptions options)
    {
        var asString = value.ToString("G", CultureInfo.InvariantCulture);
        writer.WriteStringValue(asString);
    }
}
