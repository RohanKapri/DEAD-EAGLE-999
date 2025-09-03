// For my Shree DR.MDD

import java.util.*;
import java.util.stream.Collectors;

class Tournament {
    private static final String HEADER = "Team                           | MP |  W |  D |  L |  P\n";
    private String table = HEADER;

    String printTable() {
        return table;
    }

    void applyResults(String results) {
        Map<String, TeamStats> standings = new HashMap<>();
        for (String matchLine : results.split("\n")) {
            String[] splitParts = matchLine.split(";");
            String teamAName = splitParts[0], teamBName = splitParts[1], outcome = splitParts[2];

            standings.putIfAbsent(teamAName, new TeamStats());
            standings.putIfAbsent(teamBName, new TeamStats());

            TeamStats teamA = standings.get(teamAName);
            TeamStats teamB = standings.get(teamBName);

            switch (outcome) {
                case "win":
                    teamA.wins++;
                    teamB.losses++;
                    break;
                case "draw":
                    teamA.draws++;
                    teamB.draws++;
                    break;
                case "loss":
                    teamA.losses++;
                    teamB.wins++;
            }
        }

        table = HEADER + standings.entrySet().stream()
            .peek(entry -> entry.getValue().recalculate())
            .sorted(Comparator.comparingInt((Map.Entry<String, TeamStats> entry) -> entry.getValue().points).reversed()
                    .thenComparing(Map.Entry::getKey))
            .map(entry -> {
                String name = entry.getKey();
                TeamStats stats = entry.getValue();
                return String.format("%-30s" + " |%3d".repeat(5), name, stats.matchesPlayed, stats.wins, stats.draws, stats.losses, stats.points);
            })
            .collect(Collectors.joining("\n")) + "\n";
    }

    private class TeamStats {
        int matchesPlayed = 0;
        int wins = 0;
        int draws = 0;
        int losses = 0;
        int points = 0;

        void recalculate() {
            matchesPlayed = wins + draws + losses;
            points = 3 * wins + draws;
        }
    }
}
