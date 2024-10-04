import axios from 'axios';
import { apiErrorHandler } from '../Utils/ApiErrorHandler.ts';

const axiosDefaults = {

}
export const axiosInstance = axios.create(axiosDefaults);

axiosInstance.interceptors.response.use(response => response, apiErrorHandler)