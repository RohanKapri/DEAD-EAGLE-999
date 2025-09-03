// For my Shree DR.MDD

import org.json.*;
import java.util.*;
import java.util.stream.*;

class RestApi {
    private final Map<String, User> registry;

    RestApi(User... users) {
        this.registry = Arrays.stream(users)
            .collect(Collectors.toMap(u -> u.name(), u -> u, (u1, u2) -> u1, HashMap::new));
    }

    String get(String url) {
        return wrapUserListJSON(new JSONArray(registry.keySet().stream().map(this::buildUserJSON).toList())).toString();
    }

    String get(String url, JSONObject payload) {
        JSONArray selectedUsers = new JSONArray();
        for (Object uname : payload.getJSONArray("users")) {
            selectedUsers.put(buildUserJSON(uname.toString()));
        }
        return wrapUserListJSON(selectedUsers).toString();
    }

    String post(String url, JSONObject payload) {
        if (url.equals("/add")) {
            String uname = payload.getString("user");
            registry.put(uname, User.builder().setName(uname).build());
            return buildUserJSON(uname).toString();
        } else if (url.equals("/iou")) {
            String lender = payload.getString("lender");
            String borrower = payload.getString("borrower");
            double amt = payload.getDouble("amount");
            registerIou(lender, borrower, amt);
            JSONArray pair = lender.compareTo(borrower) < 0 ? new JSONArray().put(lender).put(borrower) : new JSONArray().put(borrower).put(lender);
            return get("/users", wrapUserListJSON(pair));
        }
        return null;
    }

    private JSONObject wrapUserListJSON(JSONArray array) {
        return new JSONObject().put("users", array);
    }

    private JSONObject buildUserJSON(String uname) {
        User usr = registry.get(uname);
        JSONObject owesJSON = new JSONObject();
        JSONObject owedByJSON = new JSONObject();
        double netBalance = 0;

        for (Iou owe : usr.owes()) {
            owesJSON.put(owe.name, owe.amount);
            netBalance -= owe.amount;
        }

        for (Iou owed : usr.owedBy()) {
            owedByJSON.put(owed.name, owed.amount);
            netBalance += owed.amount;
        }

        return new JSONObject()
            .put("name", uname)
            .put("owes", owesJSON)
            .put("owedBy", owedByJSON)
            .put("balance", netBalance);
    }

    private void registerIou(String lender, String borrower, double amt) {
        User lenderUser = registry.get(lender);
        User borrowerUser = registry.get(borrower);

        List<Iou> lenderOwes = new ArrayList<>(lenderUser.owes());
        List<Iou> lenderOwedBy = new ArrayList<>(lenderUser.owedBy());
        List<Iou> borrowerOwes = new ArrayList<>(borrowerUser.owes());
        List<Iou> borrowerOwedBy = new ArrayList<>(borrowerUser.owedBy());

        lenderOwedBy.add(new Iou(borrower, amt));
        borrowerOwes.add(new Iou(lender, amt));

        refreshUser(lender, lenderOwes, lenderOwedBy);
        refreshUser(borrower, borrowerOwes, borrowerOwedBy);
    }

    private void refreshUser(String uname, List<Iou> owesList, List<Iou> owedByList) {
        User.Builder builder = User.builder().setName(uname);

        for (Iou owe : owesList) {
            double oweAmt = owe.amount;
            double counterAmt = findAmountForPerson(owe.name, owedByList);
            if (counterAmt != 0.0 && oweAmt <= counterAmt) continue;
            builder.owes(owe.name, oweAmt - counterAmt);
        }

        for (Iou owed : owedByList) {
            double owedAmt = owed.amount;
            double counterAmt = findAmountForPerson(owed.name, owesList);
            if (counterAmt != 0.0 && owedAmt <= counterAmt) continue;
            builder.owedBy(owed.name, owedAmt - counterAmt);
        }

        registry.replace(uname, builder.build());
    }

    private double findAmountForPerson(String uname, List<Iou> list) {
        return list.stream()
            .filter(iou -> iou.name.equals(uname))
            .mapToDouble(iou -> iou.amount)
            .findFirst()
            .orElse(0.0);
    }
}
