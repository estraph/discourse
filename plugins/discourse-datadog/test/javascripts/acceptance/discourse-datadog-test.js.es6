import { acceptance } from "helpers/qunit-helpers";

acceptance("DiscourseDatadog", { loggedIn: true });

test("DiscourseDatadog works", async assert => {
  await visit("/admin/plugins/discourse-datadog");

  assert.ok(false, "it shows the DiscourseDatadog button");
});
