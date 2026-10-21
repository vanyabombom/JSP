<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String invalidRoute = (String) request.getAttribute("invalidRoute");
%>
<div class="admin-404" style="background: #fff5f5; border: 1px solid #fed7d7; border-left: 5px solid #ef4444; border-radius: 10px; padding: 22px; margin-top: 15px; box-shadow: 0 4px 10px rgba(239, 68, 68, 0.06);">
    <h3 style="color: #b91c1c; margin-top: 0; font-size: 1.25rem; display: flex; align-items: center; gap: 8px;">
        <span>&#9888;</span> 404 - Внутрішній маршрут не знайдено
    </h3>
    <p style="color: #4b5563; margin-bottom: 12px; font-size: 0.96rem;">
        Запитаний підрозділ адміністративної панелі <code style="background: #fee2e2; color: #991b1b; padding: 2px 8px; border-radius: 6px; font-weight: 600;"><%= invalidRoute != null ? invalidRoute : "" %></code> не існує.
    </p>
    <p style="color: #4b5563; font-size: 0.94rem; margin-bottom: 0;">
        Будь ласка, скористайтеся меню вище або поверніться на <a href="<%= request.getContextPath() %>/admin/" style="color: #4f46e5; font-weight: 600; text-decoration: underline;">головну сторінку адмінки</a>.
    </p>
</div>
