import sys
import cricket_analytics as c_ast


def run_dashboard():
    while True:
        print("\n" + "=" * 50)
        print("     SMART CRICKET ANALYTICS PLATFORM v2.0      ")
        print("=" * 50)
        print("1. Player Analysis Dashboard")
        print("2. Team Strategic Insights")
        print("3. Boundary Tracking Analytics")
        print("4. Export Production Performance Files")
        print("5. Exit Workspace System")
        print("=" * 50)

        sel = input("Select strategic operation module (1-5): ").strip()

        if sel == "1":
            print("\n" + "-" * 20 + " PLAYER ANALYSIS MODULE " + "-" * 20)
            print("Current System Active Records:\n")
            c_ast.display_all_records()

            print(f"\nTotal Tracked Players: {c_ast.count_total_players()}")
            avg_val = c_ast.calculate_average_runs()
            print(f"Tournament Mean Batting Average: {avg_val:.2f}")

            top_p = c_ast.find_top_scorer()
            low_p = c_ast.find_lowest_run_scorer()
            print(
                f"Orange Cap Leader (Highest Scorer): {top_p['player_name']} [{top_p['runs']} Runs]"
            )
            print(
                f"Lowest Dynamic Run Accumulator   : {low_p['player_name']} [{low_p['runs']} Runs]"
            )

            print("\nElite High Performance Layer (> 600 Runs):")
            for p in c_ast.filter_players_above_600():
                print(f" - {p['player_name']} ({p['team']}): {p['runs']} runs")

            print("\nDevelopment Group Layer (< 500 Runs):")
            for p in c_ast.filter_players_below_500():
                print(f" - {p['player_name']} ({p['team']}): {p['runs']} runs")

            # Displaying requested NumPy properties validation array trace
            np_m = c_ast.calculate_numpy_metrics()
            if np_m:
                print("\n[NUMPY MATRIX MATRIX ARRAYS DATA TRACE]")
                for k, v in np_m.items():
                    print(f"  {k:<20}: {v:.2f}" if isinstance(v, float) else f"  {k:<20}: {v}")

        elif sel == "2":
            print("\n" + "-" * 20 + " TEAM ANALYSIS MODULE " + "-" * 20)
            print("Unique Registered Squad Identities:", c_ast.get_unique_teams_set())

            print("\nRoster Allocations (Player Count per Franchise):")
            for t, c in c_ast.count_players_by_team().items():
                print(f" - Team {t:<4}: {c} Players assigned")

            print("\nFranchise Combined Run Output mapping:")
            for t, r in c_ast.create_team_runs_dict().items():
                print(f" - Team {t:<4}: {r} runs cumulative")

            top_t, top_t_r = c_ast.find_best_team()
            low_t, low_t_r = c_ast.find_worst_team()
            print(f"\nDominating Standings Unit (Highest Runs): Team {top_t} ({top_t_r} runs)")
            print(f"Trailing Standings Unit (Lowest Runs)  : Team {low_t} ({low_t_r} runs)")

            # Pandas validation execution metrics preview panel
            p_vars = c_ast.process_pandas_pipeline()
            if p_vars is not None:
                print("\n[PANDAS SQUAD PERFORMANCE AVERAGES]")
                for _, row in p_vars["team_averages"].iterrows():
                    print(f" - Franchise {row['team']:<4} average score ticket: {row['runs']:.2f}")

        elif sel == "3":
            print("\n" + "-" * 20 + " BOUNDARY ANALYSIS MODULE " + "-" * 20)
            f4 = c_ast.find_player_most_fours()
            f6 = c_ast.find_player_most_sixes()
            t4, t6 = c_ast.find_total_boundaries()

            print(f"Most Boundaries along Turf (Fours): {f4['player_name']} ({f4['fours']} hits - Team {f4['team']})")
            print(f"Most Aerial Clearances (Sixes)     : {f6['player_name']} ({f6['sixes']} hits - Team {f6['team']})")
            print(f"Total Tournament Boundary Fours Combined: {t4}")
            print(f"Total Tournament Boundary Sixes Combined : {t6}")

        elif sel == "4":
            print("\nExecuting comprehensive data workspace generation writes...")
            if c_ast.generate_structured_reports():
                print("\n[SUCCESS ENGINE DISPATCH] System files generated natively inside active project folder:")
                print(" -> 'cricket_report.txt' (Complete Summary Performance Breakdown Dashboard)")
                print(" -> 'top_players.csv' (Extracted high performance records matching > 600 runs parameters)")
                print(" -> 'team_summary.csv' (Franchise breakdown matrix mapping volume totals, averages and size counters)")
            else:
                print("\n[FILE SYSTEM FAULT] Intermittent verification processing pipeline issue detected.")

        elif sel == "5":
            print("\nClosing Cricket Analytics Module. Systems standard shutdown initiated.")
            sys.exit()

        else:
            print("\n[INPUT ERROR] Code option not recognized. Please retry typing an option choice index tracking 1-5.")


if __name__ == "__main__":
    if not c_ast.players_data:
        print("Application loading failed: Check location integrity vectors for players.csv input structures.")
    else:
        run_dashboard()