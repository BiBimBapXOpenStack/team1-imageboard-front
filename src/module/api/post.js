import axios from "axios";

const getList = (payload) => axios({
    url: '/api/posts/?page='+payload.pageNumber+'&size=10',
    method: 'get',
    headers: {
        "Authorization":payload.token
    }
});

const getPost = (payload) => axios({
    url: '/api/posts/'+payload.postId,
    method: 'get',
    headers: {
        "Authorization":payload.token
    }
});

export default {
    getList,
    getPost
}