freehck/allure-report-generator
=========

This is a daemon wrapped into a docker-container, that just looks for new reports (junit, testng, etc) in one directory and generates appropriate Allure reports in another one.

At the moment, Gitlab doesn't have a plugin to produce and view Allure reports, so this daemon is a part of some simple solution:
- you just upload your test results into the `tests` directory on some file server
- `tests` directory is monitored by this daemon
- this daemon automatically takes the test results from `tests` directory, and stores generated reports into `reports` directory
- you provide people with access to `reports` directory with http

This daemon is as simple as possible. Use one daemon per project please.

It handles with history to produce trends.

It provides a symlink to `latest` report.

Build
-----

To build the image just run `make` command. To push it to dockerhub there's `make push`.

Run
---

To run it you can use something like this:

    docker run -d --name allure-report-generator -v `pwd`/tests:/allure/tests -v `pwd`/reports:/allure/reports freehck/allure-report-generator:2.13.2

I recommend to mv directories with tests into the `tests` directory for allure not to start generating reports until you finished uploading. But if you want to copy directly into it, consider setting `SLEEP_BEFORE_RUN_ALLURE` variable that is set to `0` by default.
