// For my Shree DR.MDD

import java.util.Map;
import java.util.HashMap;

public class DialingCodes {

    private Map<Integer, String> dialingMap = new HashMap<>();

    public Map<Integer, String> getCodes() {
        return this.dialingMap;
    }

    public void setDialingCode(Integer code, String country) {
        this.dialingMap.put(code, country);
    }

    public String getCountry(Integer code) {
        return this.dialingMap.get(code);
    }

    public void addNewDialingCode(Integer code, String country) {
        if (!this.dialingMap.containsKey(code) && !this.dialingMap.containsValue(country)) {
            this.dialingMap.put(code, country);
        }
    }

    public Integer findDialingCode(String country) {
        for (Map.Entry<Integer, String> entry : dialingMap.entrySet()) {
            if (entry.getValue().equals(country)) {
                return entry.getKey();
            }
        }
        return null;
    }

    public void updateCountryDialingCode(Integer code, String country) {
        Integer currentCode = findDialingCode(country);

        if (currentCode != null) {
            dialingMap.remove(currentCode);
        }

        dialingMap.put(code, country);
    }
}
