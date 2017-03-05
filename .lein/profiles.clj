{:user {:plugins [[cider/cider-nrepl  "0.14.0"]
                  [codox           "0.10.3"]
                  [jonase/eastwood "0.2.3"]
                  [lein-ancient    "0.6.10"]
                  [lein-bikeshed   "0.4.1"]
                  [lein-cloverage  "1.0.9"]
                  [lein-difftest   "2.0.0"]
                  [lein-exec       "0.3.6"]
                  [lein-licenses   "0.2.1"]
                  [lein-localrepo  "0.5.3"]
                  [lein-marginalia "0.9.0"]
                  [lein-kibit      "0.1.3"]
                  [lein-pprint     "1.1.2"]
                  [lein-try        "0.4.3"]
                  [lein-typed      "0.3.5"]
                  [perforate       "0.3.4"]]
        :search-page-size 30
        :dependencies  [[org.clojure/tools.namespace "0.2.10"]
                        [im.chit/vinyasa             "0.4.7"]
                        [jonase/kibit                "0.1.3"]
                        [spyscope                    "0.1.6"]]
        :injections  [(require 'spyscope.core)]
        :jvm-opts ["-XX:+TieredCompilation" "-XX:TieredStopAtLevel=1"]}}
