export const axiosConfig = {
  baseURL: 'https://35.239.10.9:8545',
  maxRedirects: 0,
  timeout: 35000,
  validateStatus: (status: number): boolean => status < 400,
  params: {
  },
};
