importScripts('firebase/firebase-app.js');
importScripts('firebase/firebase-messaging.js');

firebase.initializeApp({
    apiKey: 'AIzaSyDofTd7rSV7NOq8sIAlZuEww_muVwAg7LE',
    appId: '1:604989067023:web:23770f42dd7168d6a1387a',
    messagingSenderId: '604989067023',
    projectId: 'rtc-app-5e83f',
    authDomain: 'rtc-app-5e83f.firebaseapp.com',
    storageBucket: 'rtc-app-5e83f.firebasestorage.app',
    measurementId: 'G-YNLQB3VZER',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        icon: '/icons/Icon-192.png'
    };

    self.registration.showNotification(notificationTitle, notificationOptions);
});
