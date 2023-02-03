importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
var firebaseConfig = {
                       apiKey: "AIzaSyCesmG-VOABs1sNKbzSYBarGzrBA64gc60",
                       authDomain: "flutterpraxis.firebaseapp.com",
                       projectId: "flutterpraxis",
                       storageBucket: "flutterpraxis.appspot.com",
                       messagingSenderId: "1080315079875",
                       appId: "1:1080315079875:web:c1d58cb4d08c950e2c8676",
                       measurementId: "G-YD3PRBQRYJ"
                     };

firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});