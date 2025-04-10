(ns meetup.jobs
  (:require [clojure.tools.logging :as log]
            [meetup.cave.jobs :as cave-jobs]
            [proletarian.worker :as-alias worker]
            [proletarian.protocols :as protocols]
            [cheshire.core :as cheshire]))

(def json-serializer
  (reify protocols/Serializer
    (encode [_ data]
      (cheshire/generate-string data))
    (decode [_ data-string]
      (cheshire/parse-string data-string keyword))))

(defn log-level
  [x]
  (case x
    ::worker/queue-worker-shutdown-error :error
    ::worker/handle-job-exception-with-interrupt :error
    ::worker/handle-job-exception :error
    ::worker/job-worker-error :error
    ::worker/polling-for-jobs :debug
    :proletarian.retry/not-retrying :error
    :info))

(defn logger
  [x data]
  (log/logp (log-level x) x data))

(defn handlers
  []
  (merge {}
         (cave-jobs/handlers)))

(defn process-job
  [system job-type payload]
  (if-let [handler (get (handlers) job-type)]
    (do
      (log/info (pr-str system))
      (handler system job-type payload))
    (throw (ex-info "Unhandled Job Type" {:job-type job-type}))))
