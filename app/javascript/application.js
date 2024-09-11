// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// タスク編集のための関数
function editTask(id, title, body, status, baggage) {
  document.querySelector('input[name="task[title]"]').value = title;
  document.querySelector('textarea[name="task[body]"]').value = body;
  document.querySelector('select[name="task[status]"]').value = status;
  document.querySelector('select[name="task[baggage]"]').value = baggage;
  document.querySelector('input[name="task[id]"]').value = id;
}

// グローバルで利用できるようにする
window.editTask = editTask;
