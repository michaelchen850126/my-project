
<template>
  <button v-if="isLoggedIn && canComment" type="button" class="btn btn-black" @click="showAddModal" style="width: 500px;   margin: 30px;background-color: black;color: white; border: none;">
    <font-awesome-icon icon="fa-solid fa-wand-magic-sparkles" />我要評論
  </button>

<!-- 星級排序 -->
<div class="sort-radio-group" style="display: flex; justify-content: end;">
  <input 
    type="radio" 
    id="sortDesc" 
    name="sortOrder" 
    value="desc" 
    v-model="sortOrder"
    @change="sortComments2('desc')"
  />
  <p style="color: black; margin-top: 15px;padding-right: 10px;">星級高到低</p>
  <input 
    type="radio" 
    id="sortAsc" 
    name="sortOrder" 
    value="asc" 
    v-model="sortOrder"
    @change="sortComments2('asc')"
  />
  <p style="color: black; margin-top: 15px;padding-right: 10px;">星級低到高</p>
  <input
    type="radio"
    id="sortLatest" 
    name="sortOrder" 
    value="latest"
    v-model="sortOrder"
    @change="sortByLatest2"
    style="width: 13px;height: 55px;"
  >
  <p style="color: black; margin-top: 15px;padding-right: 10px;">最新評論</p>
</div>



  <!-- 分页 -->
  <div v-if="totalPages > 1" class="pagination mt-3">
    <button ref="topPrevButton" :disabled="currentPage === 0" @click="handlePageChange(currentPage - 1)" class="btn btn-secondary" style="margin-right: 5px;">上一頁</button>
   
    <button ref="topNextButton" :disabled="currentPage >= totalPages - 1" @click="handlePageChange(currentPage + 1)" class="btn btn-secondary">下一頁</button>
  </div>



<!------------------------------整個評論------------------------------------------------>
    <div style="display: flex;  justify-content: center;"><div>
    </div>
    <!--  新增評論彈窗 -->
      <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false" >
        <div class="modal-dialog">
          <div class="modal-content"  style="background-color: rgb(246, 245, 242);">
            <div class="modal-header" style="background-color: rgb(246, 245, 242);">
              <h4 class="modal-title" id="commentModalLabel"  style="color: black; font-weight: 500;">新增評論</h4>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="resetForm" ></button>
            </div>
            <div class="modal-body">
              <form @submit.prevent="addComment" style="background-color: rgb(246, 245, 242);">
                <div class="mb-3" >
                  <label for="star" class="form-label" style="color: black;font-size: 20px;display: flex;" >星级:</label>
                  <div style="display: flex;">
                    <img 
  v-for="(star, index) in 5" 
  :key="index" 
  :src="index < newComment.star ? chngStarImage : starImage" 
  @click="setRating(index + 1, 'newComment')" 
  class="star"  
/>
  <!------>
                  </div>
                  <div v-if="errors.star" class="text-danger">{{ errors.star }}</div>
                </div>
                <div class="mb-3 form-floating">
                  <textarea class="form-control" placeholder="Leave a comment here" id="comments" v-model="newComment.comments" style="height: 80px;" required></textarea>
                  <label for="floatingTextarea2">評論內容</label>
                  <div v-if="errors.comments" class="text-danger">{{ errors.comments }}</div>
                </div>
                <div class="mb-3 input-group">
                  <input type="file" class="form-control" id="inputGroupFile04" @change="handleFileUpload" ref="fileInput">
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary me-auto" data-bs-dismiss="modal">取消</button>
                  <button type="button" class="btn btn-secondary" @click="resetForm">重置</button>
                  <button type="submit" class="btn btn-primary"><font-awesome-icon :icon="['fas', 'pencil']" />新增評論</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
  <!--更新評視窗-->
      <div class="modal fade" id="editCommentModal" tabindex="-1" aria-labelledby="editCommentModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="editCommentModalLabel" style="color: black;">更新評論</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="cancelEdit"></button>
            </div>
            <div class="modal-body">
              <form @submit.prevent="updateComment(editComment.id)">
                <div class="mb-3">
                  <label for="star" class="form-label"  style="color: black;" >星级:</label>
                  <div>
                    <img
  v-for="(star, index) in 5"
  :key="index"
  :src="index < editComment.star ? chngStarImage : starImage"
  @click="setRating(index + 1, 'editComment')"
  class="star"
/>
<!------>
                  </div>
                </div>
                <div class="mb-3 form-floating">
                  <textarea class="form-control" placeholder="Leave a comment here" id="editComments" v-model="editComment.comments" style="height: 80px;" required></textarea>
                  <label for="floatingTextarea2">評論內容</label>
                </div>
                <div class="mb-3 input-group">
                  <input type="file" class="form-control" id="inputGroupFile04" @change="handleEditFileUpload" ref="fileInput">
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary me-auto" data-bs-dismiss="modal" @click="cancelEdit">取消</button>
                  <button type="submit" class="btn btn-primary">更新評論</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
  
  
  <!-- Bootstrap Modal for Image Preview 跳視窗圖片-->
  <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="imageModalLabel" style="color: black;">圖片預覽</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body d-flex justify-content-center">
          <img :src="modalImage" alt="Preview Image" class="img-fluid">
        </div>
      </div>
    </div>
  </div>
  <!--------------------------------------->
      <ul class="list-group" style="width: 1100px;">
        <li v-for="comment in comments" :key="comment.id" class="list-group-item" style="display: flex; justify-content: center; border: none;">
          <div>
            <div class="d-flex justify-content-between align-items-start">
              <div class="d-flex align-items-center">
                <img 
                  v-if="comment.userImg" 
                  :src="'data:image/jpeg;base64,' + comment.userImg" 
                  alt="User Avatar" 
                  class="user-avatar" 
                />
                <div class="ms-2">
                  <strong style="display: flex;">{{ comment.username }}</strong>
                  <div>
                    <!--我改這-->
                    <img 
                      v-for="(star, index) in 5" 
                      :key="index" 
                      :src="index < comment.star ? chngStarImage : starImage"
                      class="star" 
                    />
                    <!---->
                  </div>
                </div>
              </div>
              <div v-if="isLoggedIn && comment.userId == userId "  class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" 
                  data-bs-toggle="dropdown" aria-expanded="false">
                  <font-awesome-icon icon="fa-regular fa-pen-to-square" />編輯
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li><button class="dropdown-item" @click="editCommentItem(comment)">更新評論</button></li>
                  <li><button class="dropdown-item" @click="confirmDeleteComment(comment.id)">删除評論</button></li>
                </ul>
              </div>
            </div>
            <!--顯示圖片、評論、時間-->
            <p style="display: flex;">{{ comment.comments }}</p>
            <img v-if="comment.img" :src="'data:image/jpeg;base64,' + comment.img" alt="Comment Image" class="comment-img img-fluid" @click="showImageModal('data:image/jpeg;base64,' + comment.img)" />
  
           
            <p style="display: flex;justify-content:sta;">建立時間: {{ formatDate(comment.updatedAt) }}</p>
<!-- 顯示回覆區域collapse摺疊功能-->
<!-- 確保只有當 comment.replies 存在且長度大於 0 時才顯示按鈕 -->
<div v-if="comment.replies && comment.replies.length > 0">
  <button class="btn btn-link" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapseReplies' + comment.id" aria-expanded="false" :aria-controls="'collapseReplies' + comment.id">
    <font-awesome-icon icon="fa-solid fa-comment-dots" />賣家
  </button>
  
  <div :id="'collapseReplies' + comment.id" class="collapse">
    <ul class="list-group">
      <li v-for="reply in comment.replies" :key="reply.id" class="list-group-item">
        <p>{{ reply.replies }}</p>
        <p style="display: flex; justify-content: end;">回覆時間: {{ formatDate(reply.createdAt) }}</p>
      </li>
    </ul>
  </div>
</div>
<!---->
          </div>
        </li>
      </ul>
    </div>
  
 <!-- 分页 -->
  <!-- Pagination at the bottom -->
  <div v-if="totalPages > 1" class="pagination mt-3">
    <button :disabled="currentPage === 0" @click="handlePageChange(currentPage - 1, true)" class="btn btn-secondary" style="width: 60px;height: 45px;font-size: 11px;">上一頁</button>


  <!-- 頁碼 -->
  <ul class="pagination-list">
      <li v-for="page in totalPages" :key="page" class="page-item">
        <button 
          :class="{ 'active': currentPage === page - 1 }"
          @click="handlePageChange(page - 1)" 
          class="btn btn-secondary">
          {{ page }}
        </button>
      </li>
    </ul>

    
    <button :disabled="currentPage >= totalPages - 1" @click="handlePageChange(currentPage + 1, true)" class="btn btn-secondary custom-btn"  style="width: 60px;height: 45px;font-size: 11px;" >下一頁</button>
   
  </div>

 <span  style="color: black;">第 {{ currentPage + 1 }} 頁，共 {{ totalPages }} 頁</span>







  <!-- 滾動到頂部按鈕 -->
  <button  v-if="showScrollTopButton" class="btn btn-secondary"  @click="scrollToTop" 
  style="position: fixed; bottom: 20px; right: 20px; z-index: 1000;"
>
<font-awesome-icon icon="fa-solid fa-arrow-up" />TOP
</button>

</template>
  
  <script>
  import axiosapi from '@/plugins/axios';
  import bootstrap from 'bootstrap/dist/js/bootstrap.bundle.min.js';
  import moment from 'moment';
  import Swal from 'sweetalert2';
   // <!--我改這-->
   import chngStarImage from '@/assets/images/chngstar.gif';  
  import starImage from '@/assets/images/star.gif';

  
  export default {
  data() {
    return {
        //我改這
        chngStarImage,
      starImage,
  //
      comments: [],
      productId: 10,
      showScrollTopButton: false, // 控制回到頂部按鈕的顯示
      newComment: {
        star: 0,
        comments: '',
        img: null,
        userId: null
      },
      editComment: {
        id: null,
        star: 0,
        comments: '',
        img: null
      },
      file: null,
      editFile: null,
      errors: {
        star: null,
        comments: null
      },
      isLoggedIn: false, // 用於判斷是否登入
      canComment: false,  // 新增變數來控制是否可以評論
      username: '', // 用戶名
      userId: '',  // 用戶 ID
      modalImage: null, // 用來儲存當前顯示在 Modal 中的圖片
      sortOrder: 'desc', // 默認排序方式
      originalComments: [], // 用於保存原始評論數據
      currentPage: 0, // 当前页数
      commentsPerPage: 4, // 每页显示的评论数
      totalPages: 1, // 总页数
    };
  },
  created() {
    this.username = sessionStorage.getItem('username');
    this.userId = sessionStorage.getItem('userId');
    this.isLoggedIn = this.username !== null && this.userId !== null;
    this.fetchComments();
    this.fetchPurchaseStatus();
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    handleScroll() {
      this.showScrollTopButton = window.scrollY > 500; // 例如滾動超過500px顯示按鈕
    },
    scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    },
    fetchPurchaseStatus() {
    if (!this.userId) {
      console.error('User ID is not defined');
      return;
    }

    axiosapi.get(`/comments/status/${this.userId}`)
      .then(response => {
        console.log('API Response:', response.data);
        if (response.data && Array.isArray(response.data)) {
          // 筛选产品ID在1到9之间且状态为1的订单
          this.canComment = response.data.some(order => order.status === 1 && order.productId >= 10 && order.productId <= 18);
          console.log("canComment成功", this.canComment); // 打印 canComment 的值

          // 打印符合条件的订单信息
          response.data.forEach(order => {
            if (order.status === 1 && order.productId >= 10 && order.productId <= 18) {
              console.log(`Order ID: ${order.orderId}, Status: ${order.status}, Product ID: ${order.productId}`);
            }
          });

        } else {
          console.error('Unexpected response data format:', response.data);
        }
      })
      .catch(error => {
        console.error('There was an error fetching purchase status!', error);
      });
  },






   // 更新顯示的評論
  updateDisplayedComments() {
  const startIndex = this.currentPage * this.commentsPerPage;
  const endIndex = startIndex + this.commentsPerPage;
  this.comments = this.originalComments.slice(startIndex, endIndex);
},  // 處理頁碼變化
  handlePageChange(page, fromBottom = false) {
    if (page < 0 || page >= this.totalPages) return; // 确保页码在有效范围内
    this.currentPage = page;// 更新当前页码
    this.updateDisplayedComments();
    if (fromBottom) { // 检查是否从底部分页按钮触发(觸發後會滾輪往上滑)
        this.$nextTick(() => {// 在 DOM 更新完成后执行
          this.$refs.topPrevButton.scrollIntoView({ behavior: 'smooth' });
        });
      }
  },

  // 按照星級排序
  sortComments(order) {
    this.sortOrder = order;
    this.originalComments.sort((a, b) => {
      return order === 'asc' ? a.star - b.star : b.star - a.star;
    });
    this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
    
    // 保证 currentPage 在有效范围内
    if (this.currentPage >= this.totalPages) {
      this.currentPage = this.totalPages - 1;
    }
    
    this.updateDisplayedComments();
  },
  // 按照最新評論排序
  sortByLatest() {
    this.sortOrder = 'latest';
    this.originalComments.sort((a, b) => new Date(b.updatedAt) - new Date(a.updatedAt));
    this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
    
    // 保证 currentPage 在有效范围内
    if (this.currentPage >= this.totalPages) {
      this.currentPage = this.totalPages - 1;
    }
    
    this.updateDisplayedComments();
  },


  sortComments2(order) {
    this.sortOrder = order;
    this.originalComments.sort((a, b) => {
      return order === 'asc' ? a.star - b.star : b.star - a.star;
    });
    this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
    this.currentPage = 0; // 排序後重置為第1頁
    this.updateDisplayedComments();
  },
  // 按照最新評論排序
  sortByLatest2() {
  this.sortOrder = 'latest';
  // 按照更新时间从新到旧排序
  this.originalComments.sort((a, b) => new Date(b.updatedAt) - new Date(a.updatedAt));
  this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
  this.currentPage = 0; // 排序后重置为第1页
  this.updateDisplayedComments();
},


//重新更新頁面
fetchComments() {
  axiosapi.get(`/comments/products/${this.productId}/18`)
      .then(response => {
        console.log('Fetched Comments:', response.data); // 确认数据是否正确
        this.comments = response.data;
        this.originalComments = response.data;
      // 排序评论，按更新时间降序排序
      this.comments.sort((a, b) => new Date(b.updatedAt) - new Date(a.updatedAt));



        // 更新页数和当前页码
        this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
        this.currentPage = 0; // 默认显示第1页
        this.updateDisplayedComments(); // 加载时更新显示的评论
        this.sortByLatest(); // 加载时默认按最新排序
        console.log(this.comments); // 检查 comments 中的 userId 是否存在
      })
      .catch(error => {
        console.error('There was an error!', error);
      });
  },

  fetchUpdate() {
    axiosapi.get(`/comments/products/${this.productId}/18`)
      .then(response => {
        console.log('Fetched Comments:', response.data); // 确认数据是否正确
        this.comments = response.data;
        this.originalComments = response.data;


        // 排序评论，按更新时间降序排序
        this.comments.sort((a, b) => new Date(b.updatedAt) - new Date(a.updatedAt));

        // 重新计算总页数
        this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
        
         // 保持当前页码在有效范围内
        if (this.currentPage >= this.totalPages) {
          this.currentPage = this.totalPages - 1;
        }

        this.updateDisplayedComments(); // 更新显示的评论
        console.log(this.comments); // 检查 comments 中的 userId 是否存在
      })
      .catch(error => {
        console.error('There was an error!', error);
      });
  },


//上傳文件處理邏輯    
      handleFileUpload(event) { 
        this.file = event.target.files[0];
      },
// 編輯文件上傳處理邏輯
      handleEditFileUpload(event) {
        this.editFile = event.target.files[0];
      },
      setRating(rating, type) {
        if (type === 'newComment') {
          this.newComment.star = rating;
        } else if (type === 'editComment') {
          this.editComment.star = rating;
        }
        this.errors.star = null;
      },

  addComment() {
  this.errors = {
    star: null,
    comments: null
  };

  if (this.newComment.star === 0) {
    this.errors.star = '請選擇星級';
  }
  if (!this.newComment.comments.trim()) {
    this.errors.comments = '請輸入評論內容';
  }

  if (this.errors.star || this.errors.comments) {
    return;
  }

  // 从 sessionStorage 获取当前产品 ID
  const productId = sessionStorage.getItem('productId');

  const formData = new FormData();
  formData.append('star', this.newComment.star);
  formData.append('comments', this.newComment.comments);
  if (this.file) {
    formData.append('file', this.file); // 确保这个 'file' 的 key 和服务器端一致
  }
  formData.append('productId', this.productId);  // 确保 productId 是整数
  formData.append('userId', this.userId);  // 确保 userId 是整数

  axiosapi.post('/comments/add', formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
  .then(response => {
    this.originalComments.push(response.data); // 更新原始評論數據
    this.totalPages = Math.ceil(this.originalComments.length / this.commentsPerPage);
     this.currentPage = 0; // 新增評論後顯示第1頁
    this.comments.push(response.data);// 即時更新 comments 陣列
    this.updateDisplayedComments();
    this.resetForm();
    this.hideAddModal();
    Swal.fire({
      icon: 'success',
      title: '新增成功',
    });
    this.fetchComments();

  })
  .catch(error => {
    console.error('There was an error!', error);
  });
},
    editCommentItem(comment) {
        this.editComment = { ...comment };
        this.showEditModal();
      },
// 更新評論邏輯
      updateComment(id) {
        const formData = new FormData();
        formData.append('comment', new Blob([JSON.stringify(this.editComment)], { type: 'application/json' }));
        if (this.editFile) {
          formData.append('file', this.editFile);
        }
  
        axiosapi.put(`/comments/update/${id}`, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        })
        .then(response => {
          this.fetchUpdate();
          this.cancelEdit();
            this.handlePageChange(0); // 更新评论后跳回第一页
          Swal.fire({
            icon: 'success',
            title: '更新成功',
          });
        })
        .catch(error => {
          console.error('There was an error!', error);
        });
      },
// 編輯評論項目邏輯
    editCommentItem(comment) {
        this.editComment = { ...comment };
        this.showEditModal();
      },
// 確認刪除評論
      confirmDeleteComment(commentId) {
        Swal.fire({
          title: '確定刪除嗎?',
          text: '您將無法恢復此評論!',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: '是的, 刪除它!'
        }).then(result => {
          if (result.isConfirmed) {
            this.deleteComment(commentId);
          }
        });
      },
      deleteComment(commentId) {
        axiosapi.delete(`/comments/deleteCommentReply/${commentId}`)
          .then(() => {
            this.comments = this.comments.filter(comment => comment.id !== commentId);
            Swal.fire('已刪除!', '您的評論已被刪除.', 'success');
          })
          .catch(error => {
            console.error('There was an error!', error);
          });
      },
// 重置表單
      resetForm() {
        console.log(this.$refs.fileInput); // 检查是否有文件输入的引用
        this.newComment = {
          star: 0,
          comments: '',
          img: null,
          userId: this.userId // 保持userId不变
        };
        this.file = null;
        if (this.$refs.fileInput) {
          this.$refs.fileInput.value = ''; // 清空文件输入
        }
        this.errors = {
          star: null,
          comments: null
        };
      },
// 取消編輯
      cancelEdit() {
        this.editComment = {
          id: null,
          star: 0,
          comments: '',
          img: null
        };
        this.editFile = null;
        this.$refs.fileInput.value = null;
        this.hideEditModal();
      },
// 顯示新增評論模態框
      showAddModal() {
        const addModal = new bootstrap.Modal(document.getElementById('commentModal'));
        addModal.show();
      },//showImageModal
      showImageModal(imageSrc) {
    this.modalImage = imageSrc;
    const imageModal = new bootstrap.Modal(document.getElementById('imageModal'));
    imageModal.show();
  },
  
      
      hideAddModal() {
        const addModal = bootstrap.Modal.getInstance(document.getElementById('commentModal'));
        addModal.hide();
      },
      showEditModal() {
        const editModal = new bootstrap.Modal(document.getElementById('editCommentModal'));
        editModal.show();
      },
      hideEditModal() {
        const editModal = bootstrap.Modal.getInstance(document.getElementById('editCommentModal'));
        editModal.hide();
      },
      formatDate(dateString) {
        return moment(dateString).format('YYYY-MM-DD HH:mm:ss');
      }
    }
  };
  </script>
  
  <style>
  
  .list-group-item {
  border-radius: 5px; /* 圆角边框 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 立体效果的阴影 */
  background-color: #fff; /* 背景颜色 */
  margin-bottom: 10px; /* 列表项之间的间距 */
  padding: 20px; /* 添加内边距 */
}

.star {
  width: 20px;
  cursor: pointer;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.comment-img {
  width: 150px; /* 縮小圖片 */
  height: auto;
  cursor: pointer;
  margin-top: 10px; /* 添加上间距 */
}

.btn-black:hover {
  background-color: #333;
  color: white;
}

/* 排序按鈕的樣式 */
.sort-radio-btn {
  display: inline-block;
  width: 200px;
  height: 40px;
  border-radius: 20px;
  border: 2px solid black;
  color: black;
  text-align: center;
  line-height: 40px;
  cursor: pointer;
  margin: 0 10px;
  position: relative;
  transition: background-color 0.3s, color 0.3s;
}

/* 選中狀態的樣式 */
.sort-radio-group input[type="radio"]:checked + .sort-radio-btn {
  background-color: #333;
  color: black;
}

/* 鼠標懸停時的樣式 */
.sort-radio-btn:hover {
  background-color: #333;
  color: #fff;
}


.pagination-list {
  display: flex;
  list-style-type: none;
  padding: 0;
}

.page-item {
  margin: 0 2px;
}

.page-item .btn {
  padding: 0.5em 1em;
}

.page-item .btn.active {
  background-color: #007bff;
  color: white;
}
.custom-btn {
  padding: 2px 6px; /* 调整内边距 */
  font-size: 8px; /* 调整字体大小 */
  border-radius: 4px; /* 可选：调整圆角 */
}
</style>