import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.Config || 'http://localhost:8090',
  withCredentials: true,
});

export default api;