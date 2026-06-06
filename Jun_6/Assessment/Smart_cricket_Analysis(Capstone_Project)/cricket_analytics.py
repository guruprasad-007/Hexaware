import csv
import numpy as np
import pandas as pd


# ==========================================
# PART 7: Exception Handling Data Fallbacks
# ==========================================
def read_players_csv_safely(filepath):
    """Task 1 & Task 25-27: Reads dataset applying localized data guardrails."""
    players = []
    try:
        with open(filepath, mode="r", newline="", encoding="utf-8") as file:
            reader = csv.DictReader(file)
            for row in reader:
                # Task 27: Validate and sanitize Match counts
                try:
                    row["matches"] = int(row["matches"])
                except ValueError:
                    print(
                        f"Warning: Invalid matches format for ID {row.get('player_id')}. Defaulting to 0."
                    )
                    row["matches"] = 0

                # Task 26: Validate and sanitize Runs values
                try:
                    row["runs"] = int(row["runs"])
                except ValueError:
                    print(
                        f"Warning: Corrupt run value found for ID {row.get('player_id')}. Defaulting to 0."
                    )
                    row["runs"] = 0

                # Sanitize safe boundary integers
                row["fours"] = int(row.get("fours", 0))
                row["sixes"] = int(row.get("sixes", 0))

                players.append(row)
        return players
    except FileNotFoundError:
        print(
            f"CRITICAL ERROR: File '{filepath}' is completely missing from current directory workspace."
        )
        return []


# Initialize raw baseline array variables globally
DATA_FILE = "players.csv"
players_data = read_players_csv_safely(DATA_FILE)


# ==========================================
# PART 1 & 2: Native Player Analytics
# ==========================================


def display_all_records():
    """Task 2: Tabulate data display matrix format."""
    if not players_data:
        print("No active database records found.")
        return
    print(
        f"{'ID':<5} | {'Player Name':<16} | {'Team':<5} | {'Matches':<7} | {'Runs':<5} | {'4s':<4} | {'6s':<4}"
    )
    print("-" * 62)
    for p in players_data:
        print(
            f"{p['player_id']:<5} | {p['player_name']:<16} | {p['team']:<5} | {p['matches']:<7} | {p['runs']:<5} | {p['fours']:<4} | {p['sixes']:<4}"
        )


def count_total_players():
    """Task 3: Count total players entries."""
    return len(players_data)


def find_top_scorer():
    """Task 4 & Task 21: Native optimization parsing high run record."""
    if not players_data:
        return None
    return max(players_data, key=lambda x: x["runs"])


def find_lowest_run_scorer():
    """Task 5: Locate low record placeholder target row."""
    if not players_data:
        return None
    return min(players_data, key=lambda x: x["runs"])


def calculate_average_runs():
    """Task 6 & Task 22: Calculate average runs profile."""
    if not players_data:
        return 0.0
    return sum(p["runs"] for p in players_data) / len(players_data)


def filter_players_above_600():
    """Task 7: Extract list segment scaling > 600 target threshold."""
    return [p for p in players_data if p["runs"] > 600]


def filter_players_below_500():
    """Task 8: Extract list segment tracking under 500 target threshold."""
    return [p for p in players_data if p["runs"] < 500]


# ==========================================
# PART 3 & 4: Team and Boundary Aggregators
# ==========================================


def count_players_by_team():
    """Task 9: Generates frequency maps of registered active squad sizes."""
    team_counts = {}
    for p in players_data:
        team_counts[p["team"]] = team_counts.get(p["team"], 0) + 1
    return team_counts


def create_team_runs_dict():
    """Task 10 & Task 19: Build lookup map for team gross metrics."""
    team_runs = {}
    for p in players_data:
        team_runs[p["team"]] = team_runs.get(p["team"], 0) + p["runs"]
    return team_runs


def find_best_team():
    """Task 11 & Task 23: Return top run producing roster group asset."""
    t_runs = create_team_runs_dict()
    if not t_runs:
        return None, 0
    best = max(t_runs, key=t_runs.get)
    return best, t_runs[best]


def find_worst_team():
    """Task 12: Return bottom index gross group."""
    t_runs = create_team_runs_dict()
    if not t_runs:
        return None, 0
    worst = min(t_runs, key=t_runs.get)
    return worst, t_runs[worst]


def find_player_most_fours():
    """Task 13: Locate profile with extreme perimeter 4s tally."""
    return (
        max(players_data, key=lambda x: x["fours"]) if players_data else None
    )


def find_player_most_sixes():
    """Task 14: Locate profile with extreme lofted aerial 6s tally."""
    return (
        max(players_data, key=lambda x: x["sixes"]) if players_data else None
    )


def find_total_boundaries():
    """Task 15, 16 & Task 24: Aggregate combined historical boundary tracking."""
    fours = sum(p["fours"] for p in players_data)
    sixes = sum(p["sixes"] for p in players_data)
    return fours, sixes


# ==========================================
# PART 5: Lists, Sets and Dictionaries
# ==========================================


def get_sorted_player_names_list():
    """Task 17: Extends alphabetical array string slice mappings."""
    return sorted([p["player_name"] for p in players_data])


def get_unique_teams_set():
    """Task 18: Isolate clean distinct team entities."""
    return set(p["team"] for p in players_data)


def create_player_runs_dict():
    """Task 20: Identity indexing for specific running totals map."""
    return {p["player_name"]: p["runs"] for p in players_data}


# ==========================================
# PART 8: NumPy Matrix Analytics
# ==========================================


def calculate_numpy_metrics():
    """Task 28: Runs array modeling vector calculations matching requirements."""
    runs_list = [p["runs"] for p in players_data]
    if not runs_list:
        return None

    np_runs = np.array(runs_list)
    return {
        "Total Runs": np.sum(np_runs),
        "Average Runs": np.mean(np_runs),
        "Maximum Runs": np.max(np_runs),
        "Minimum Runs": np.min(np_runs),
        "Standard Deviation": np.std(np_runs),
        "Median": np.median(np_runs),
    }


# ==========================================
# PART 9: Pandas Advanced Analytical Pipeline
# ==========================================


def process_pandas_pipeline():
    """Task 29-35: Execute analytics processing via DataFrames."""
    try:
        # Task 29: Read CSV using Pandas
        df = pd.read_csv(DATA_FILE)

        # Task 30: Top 5 run scorers
        top_5 = df.sort_values(by="runs", ascending=False).head(5)

        # Task 31: All players sorted descending
        sorted_all = df.sort_values(by="runs", ascending=False)

        # Task 32: Group by team total runs
        team_totals = df.groupby("team")["runs"].sum().reset_index()

        # Task 33: Group by team average runs
        team_averages = df.groupby("team")["runs"].mean().reset_index()

        # Task 34: Mask filtering runs > 600
        above_600 = df[df["runs"] > 600]

        # Task 35: Top team location matrix via group sorting index
        top_team_row = (
            df.groupby("team")["runs"]
            .sum()
            .sort_values(ascending=False)
            .index[0]
        )

        return {
            "df": df,
            "top_5": top_5,
            "sorted_all": sorted_all,
            "team_totals": team_totals,
            "team_averages": team_averages,
            "above_600": above_600,
            "top_team": top_team_row,
        }
    except Exception as e:
        print(f"Error executing internal Pandas computation pipeline frame: {e}")
        return None


# ==========================================
# REPORT COMPONENT & TASK 36-37 FILE GENERATOR
# ==========================================


def generate_structured_reports():
    """Triggers filesystem text dumps and filtered custom summary file generations."""
    p_vars = process_pandas_pipeline()
    if not p_vars:
        return False

    df = p_vars["df"]

    # 1. Generate text dashboard summary frame profile
    with open("cricket_report.txt", "w", encoding="utf-8") as f:
        f.write("==================================================\n")
        f.write("        CRICKET TOURNAMENT ANALYTICS REPORT        \n")
        f.write("==================================================\n\n")

        f.write(f"Total Active System Players : {count_total_players()}\n")
        f.write(
            f"Total Tournament Runs       : {p_vars['team_totals']['runs'].sum()}\n"
        )
        f.write(f"Average Base Runs Scored    : {calculate_average_runs():.2f}\n")

        top_s = find_top_scorer()
        low_s = find_lowest_run_scorer()
        f.write(
            f"Tournament Leaderboard High : {top_s['player_name']} ({top_s['runs']} runs)\n"
        )
        f.write(
            f"Tournament Baseline Low     : {low_s['player_name']} ({low_s['runs']} runs)\n\n"
        )

        f.write("--- Team Wise Runs Pipeline ---\n")
        for _, row in p_vars["team_totals"].iterrows():
            f.write(f" Team {row['team']:<5}: {row['runs']} runs\n")

        f.write("\n--- Tournament Top 5 Leading Scorers ---\n")
        for idx, row in p_vars["top_5"].iterrows():
            f.write(
                f" {idx+1}. {row['player_name']:<15} | Team: {row['team']:<4} | Runs: {row['runs']}\n"
            )

        f4 = find_player_most_fours()
        f6 = find_player_most_sixes()
        tot_4, tot_6 = find_total_boundaries()
        f.write(f"\nMost Fours Hit Marker       : {f4['player_name']} ({f4['fours']})\n")
        f.write(f"Most Sixes Hit Marker       : {f6['player_name']} ({f6['sixes']})\n")
        f.write(f"Total Tournament Fours      : {tot_4}\n")
        f.write(f"Total Tournament Sixes      : {tot_6}\n")
        f.write("\n==================================================\n")

    # Task 36: Generate top_players.csv (Runs > 600 tracking)
    p_vars["above_600"].to_csv("top_players.csv", index=False)

    # Task 37: Generate team_summary.csv
    team_counts_series = df.groupby("team")["player_id"].count()
    team_summary_df = (
        df.groupby("team")["runs"]
        .agg(["sum", "mean"])
        .reset_index()
        .rename(columns={"sum": "Total Runs", "mean": "Average Runs"})
    )
    team_summary_df["Player Count"] = team_summary_df["team"].map(
        team_counts_series
    )
    team_summary_df.rename(columns={"team": "Team"}).to_csv(
        "team_summary.csv", index=False
    )

    return True
