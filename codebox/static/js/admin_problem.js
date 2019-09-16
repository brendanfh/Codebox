// Generated by CoffeeScript 2.4.1
(function() {
  var save_testcase, setup_handlers;

  save_testcase = function(test_case_id) {
    var input, order, output;
    input = $(`[data-tc-input-id="${test_case_id}"]`).val();
    output = $(`[data-tc-output-id="${test_case_id}"]`).val();
    order = $(`[data-tc-order-id="${test_case_id}"]`).val();
    return $.post('/admin/testcases/edit', {
      "test_case_id": test_case_id,
      "input": input || "",
      "output": output || "",
      "order": order
    }, function(data) {
      return console.log(data);
    });
  };

  setup_handlers = function() {
    $('[data-tc-save-all]').click(function() {
      var elements;
      elements = $('[data-tc-save]');
      elements.each(function(k, e) {
        var test_case_id;
        test_case_id = $(e).attr('data-tc-save');
        return save_testcase(test_case_id);
      });
      alert('Saved all test cases');
      return window.location.reload();
    });
    $('[data-tc-save]').click(function(e) {
      var test_case_id;
      test_case_id = $(e.target).attr('data-tc-save');
      save_testcase(test_case_id);
      alert('Saved test case');
      return window.location.reload();
    });
    $('[data-tc-delete]').click(function(e) {
      var test_case_id;
      test_case_id = $(e.target).attr('data-tc-delete');
      return $.post('/admin/testcases/delete', {
        "test_case_id": test_case_id
      }, function(data) {
        $(`[data-testcase="${test_case_id}"]`).remove();
        return console.log(data);
      });
    });
    $('[data-new-tc]').click(function(e) {
      var problem_name;
      problem_name = $(e.target).attr('data-new-tc');
      return $.post('/admin/testcases/new', {
        short_name: problem_name
      }, function(data) {
        console.log(data);
        return $('.test-cases').after(data.html);
      });
    });
    return $('[data-problem-delete]').click(function(e) {
      var problem_name;
      if (!confirm('Are you sure you want to delete this problem?')) {
        return;
      }
      problem_name = $(e.target).attr('data-problem-delete');
      return $.post('/admin/problems/delete', {
        short_name: problem_name
      }, function(data) {
        alert(`Deleted ${problem_name}.`);
        return window.location.reload();
      });
    });
  };

  $(document).ready(function() {
    return setup_handlers();
  });

}).call(this);

//# sourceMappingURL=admin_problem.js.map
