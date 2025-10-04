const withPWA = require("next-pwa")({ dest: "public", register: true, skipWaiting: true, disable: process.env.NODE_ENV === "development" });
module.exports = withPWA({ reactStrictMode: true, i18n: { locales: ['en','am','om','ti'], defaultLocale: 'en' } });
