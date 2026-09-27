<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>
<div class="card">
    <h2>Випробування HTTP-методів (/back)</h2>
    <p>Тестування передачі даних усіма HTTP-методами запиту до сервлета <code>BackServlet</code>.</p>

    <div style="margin-top: 14px;">
        <label for="requestPayload" style="display: block; font-weight: bold; margin-bottom: 6px;">
            Тіло запиту / Параметр:
        </label>
        <input type="text" id="requestPayload" value="Hello HTTP" 
               style="width: 100%; max-width: 450px; font-family: Consolas, monospace;" />
    </div>

    <div style="margin-top: 16px; display: flex; gap: 8px; flex-wrap: wrap;">
        <button id="btnGet" onclick="sendRequest('GET')" style="background: #0369a1; color: white;">
            GET
        </button>
        <button id="btnPost" onclick="sendRequest('POST')" style="background: #047857; color: white;">
            POST
        </button>
        <button id="btnPut" onclick="sendRequest('PUT')" style="background: #c2410c; color: white;">
            PUT
        </button>
        <button id="btnPatch" onclick="sendRequest('PATCH')" style="background: #6d28d9; color: white;">
            PATCH
        </button>
        <button id="btnDelete" onclick="sendRequest('DELETE')" style="background: #b91c1c; color: white;">
            DELETE
        </button>
    </div>
</div>

<div class="card" style="margin-top: 16px;">
    <h3>Результат запиту:</h3>
    <div style="margin-top: 8px;">
        <p><b>Останній виконаний метод:</b> <span id="resMethod" style="font-family: Consolas, monospace; font-weight: bold; color: #0f766e;">-</span></p>
        <p><b>Статус відповіді:</b> <span id="resStatus" style="font-family: Consolas, monospace;">-</span></p>
        <p style="margin-top: 8px;"><b>Передані дані:</b></p>
        <pre id="sentData" style="min-height: 24px;">-</pre>
        <p style="margin-top: 8px;"><b>Отримана відповідь сервера (JSON):</b></p>
        <pre id="resBody" style="min-height: 48px;">Натисніть будь-яку кнопку вище для відправки запиту.</pre>
    </div>
</div>

<script>
function sendRequest(method) {
    const payloadInput = document.getElementById("requestPayload").value;
    const resMethod = document.getElementById("resMethod");
    const resStatus = document.getElementById("resStatus");
    const sentData = document.getElementById("sentData");
    const resBody = document.getElementById("resBody");

    resMethod.innerText = method;
    resStatus.innerText = "Відправка запиту...";
    resBody.innerText = "Очікування...";

    let url = "<%= contextPath %>/back";
    let options = {
        method: method,
        headers: {
            "Accept": "application/json"
        }
    };

    if (method === "GET") {
        url += "?data=" + encodeURIComponent(payloadInput) + "&raw=1";
        sentData.innerText = "URL Parameter: data=" + payloadInput;
    } else {
        options.headers["Content-Type"] = "application/json; charset=UTF-8";
        const jsonBody = JSON.stringify({ message: payloadInput, timestamp: Date.now() });
        options.body = jsonBody;
        sentData.innerText = "HTTP Body (JSON): " + jsonBody;
    }

    fetch(url, options)
        .then(response => {
            resStatus.innerText = response.status + " " + response.statusText;
            return response.json();
        })
        .then(data => {
            resBody.innerText = JSON.stringify(data, null, 2);
        })
        .catch(error => {
            resStatus.innerText = "Помилка виконання";
            resBody.innerText = error.toString();
        });
}
</script>
