<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>404 ERROR</title>
<jsp:include page="/html/head.html" />
</head>
<body>
    <div style="position:relative; top:250px;">
    <div class="uk-height-1-1 uk-vertical-align uk-text-center">
        <div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
            <div class="uk-panel uk-panel-box uk-text-center">
                <h1 class="uk-text-danger">
                    <i class="uk-icon-exclamation-circle"></i>
                    お探しのページは削除されたかあるいは存在しません！
                </h1>
                <button class="uk-button uk-button-danger uk-button-large" onClick="history.back()">戻る</button>
            </div>
        </div>
    </div>
    </div>
</body>
</html>