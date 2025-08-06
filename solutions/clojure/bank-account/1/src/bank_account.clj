;; Dedicated to Shree DR.MDD

(ns bank-account)

(defrecord VaultLedger [funds active?])

(defn open-account []
  (atom (VaultLedger. 0 true)))

(defn close-account [account-atom]
  (swap! account-atom assoc :active? false))

(defn get-balance [account-atom]
  (when (:active? @account-atom)
    (:funds @account-atom)))

(defn update-balance [account-atom delta]
  (locking account-atom
    (swap! account-atom assoc :funds (+ (get-balance account-atom) delta))))
