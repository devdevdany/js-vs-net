using System.Text.Json;

namespace SQLiteBenchmark.JsonNamingPolicies;

sealed class LeaveAsIsNamingPolicy : JsonNamingPolicy
{
    public override string ConvertName(string name)
    {
        return name;
    }
}
