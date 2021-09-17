
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.onCreatePost = functions.firestore.document('/posts{postId}').onCreate(
async(snapshot, context) => {

//getting post id
 const postId = context.params.postId;

 // getting the author of the post
  const authorRef = snapshot.get('author');
  const authorId = authorRef.path.split('/')[1];

//getting all the users
 const usersfeedRef = admin.firestore().collection('users').doc();

 const usersSnapshot = await usersfeedRef.get();



// usersSnapshot.forEach(doc) => {
// admin.firestore().collection('posts').doc(doc.id).collection('userFeed').doc(postId).set(snapshot.data());
// }


 });