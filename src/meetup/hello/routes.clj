(ns meetup.hello.routes
  (:require [hiccup2.core :as hiccup]
            [meetup.system :as-alias system]
            [meetup.page-html.core :as page-html]
            [next.jdbc :as jdbc]))

(defn hello-handler
  [{::system/keys [db]} _request]
  (let [{:keys [planet]} (jdbc/execute-one!
                          db
                          ["SELECT 'Earth' as planet"])]
    {:status 200
     :headers {"Content-Type" "text/html"}
     :body (str
            (hiccup/html
              (page-html/view
                :body [:h1 (str "Hello, " planet)])))}))

(defn routes
  [system]
  [["/" {:get {:handler (partial #'hello-handler system)}}]])
