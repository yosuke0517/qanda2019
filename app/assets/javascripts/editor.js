// $(function(){
//     console.log('hello')
//     CKEDITOR.replace('editor', {});
// });
$(function(){
ClassicEditor
    .create( document.querySelector( '#editor' ) )
    .catch( error => {
        console.error( error );
    } );
    width:500;
    height:100;
});