import 'axios'

const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute("content");
if (token) {
  axios.defaults.headers.common["X-CSRF-Token"] = token
}

export default axios