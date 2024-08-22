<template>
  <div ref="exampleRef" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel"><strong>JST廣播!!!</strong></h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <ul>
              <li v-for="msg in information" :key="msg.timestamp">
                <strong style="color: blue; font-size: x-large;">{{ msg.content }}</strong> - <small>{{ msg.timestamp }}</small>
              </li>
            </ul>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-dark" @click="hideModal">OK</button>
        </div>
      </div>
    </div>
  </div>
  </template>
  
  <script setup>
  import bootstrap from "bootstrap/dist/js/bootstrap.bundle.min.js"
  import { ref, onMounted } from 'vue'
  import { Client } from '@stomp/stompjs';
  import SockJS from 'sockjs-client/dist/sockjs.min.js';
  
  const client = ref(null);
  const information = ref([]); // 初始化为空数组
  const exampleRef = ref(null);
  const exampleModal = ref(null);
  
  onMounted(() => {
    exampleModal.value = new bootstrap.Modal(exampleRef.value);
    initWebSocket();
    hideModal();
  });
  
  function showModal() {
      exampleModal.value.show();
  }
  
  function hideModal() {
    exampleModal.value.hide();
  }
  
  defineExpose({ showModal, hideModal });
  
  function initWebSocket() {
    client.value = new Client({
      brokerURL: 'ws://192.168.23.149:8080/cloth/ws/chat',
      webSocketFactory: () => new SockJS('http://192.168.23.149:8080/cloth/ws/chat'),
      connectHeaders: {},
      debug: function (str) {
        console.log(str);
      },
      onConnect: () => {
        console.log('WebSocket connected');
  
        if (client.value) {
          const topic = `/topic/toUser/Coupon`;
          console.log('Subscribing to topic:', topic);
          client.value.subscribe(topic, (message) => {
            try {
              const parsedMessage = JSON.parse(message.body);
              information.value.push({
                content: parsedMessage.content,
                timestamp: new Date(parsedMessage.timestamp).toLocaleString()
              });
              showModal();
            } catch (error) {
              console.error('Error parsing message:', error);
            }
          });
        }
      },
      onStompError: (frame) => {
        console.error('STOMP Error', frame);
      },
      onDisconnect: () => {
        console.log('WebSocket disconnected');
      }
    });
    client.value.activate();
  }
  </script>
  
  <style scoped>

  

  </style>
  