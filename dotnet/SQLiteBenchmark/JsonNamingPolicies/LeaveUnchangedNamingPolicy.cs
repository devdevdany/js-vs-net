using System.Text.Json;

namespace SQLiteBenchmark.JsonNamingPolicies;

sealed class LeaveUnchangedNamingPolicy : JsonNamingPolicy
{
    public override string ConvertName(string name)
    {
        return name;
    }
}
