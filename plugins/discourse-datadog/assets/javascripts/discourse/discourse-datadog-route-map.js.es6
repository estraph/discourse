export default function() {
  this.route("discourse-datadog", function() {
    this.route("actions", function() {
      this.route("show", { path: "/:id" });
    });
  });
};
