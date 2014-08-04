{:user {:plugins [[codox           "0.8.10"]
                  [jonase/eastwood "0.1.4"]
                  [lein-ancient    "0.5.5"]
                  [lein-bikeshed   "0.1.7"]
                  [lein-cloverage  "1.0.2"]
                  [lein-difftest   "2.0.0"]
                  [lein-exec       "0.3.4"]
                  [lein-licenses   "0.1.1"]
                  [lein-localrepo  "0.5.3"]
                  [lein-marginalia "0.7.1"]
                  [lein-kibit      "0.0.8"]
                  [lein-pprint     "1.1.1"]
                  [lein-try        "0.4.1"]
                  [lein-typed      "0.3.5"]
                  [perforate       "0.3.3"]]
        :search-page-size 30
        :dependencies  [[org.clojure/tools.namespace "0.2.5"]
                        [im.chit/vinyasa             "0.2.1"]
                        [io.aviso/pretty             "0.1.12"]
                        [jonase/kibit                "0.0.8"]
                        [spyscope                    "0.1.4"]]
        :injections  [(require 'spyscope.core)]
        :repl-options {
                       :nrepl-middleware [io.aviso.nrepl/pretty-middleware]
                       }
        :jvm-opts ["-XX:+TieredCompilation" "-XX:TieredStopAtLevel=1"]}}
