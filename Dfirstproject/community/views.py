from django.shortcuts import render, get_object_or_404
from django.utils import timezone
from community.models import Post 
from community.models import Question

# Create your views here.

def List(request):
    posts = Post.objects.filter(upload_time__lte = timezone.now()).order_by('upload_time') # posting 속 객체를 게시물 업로드 순서에 따라 배열
    questions = Question.objects.filter(upload_time__lte = timezone.now()).order_by('upload_time') # posting 속 객체를 게시물 업로드 순서에 따라 배열
    return render(request, 'list.html', {'posts' : posts, 'questions' : questions}) # 화면에 보이게 렌더링

def detail(request, pk):
    post = get_object_or_404(Post, pk=pk) # 게시글을 업로드 할 때마다 매기는 번호
    return render(request, 'detail.html', {'post':post})

def question_list(request):
    questions = Question.objects.filter(upload_time__lte=timezone.now()).order_by('upload_time')
    return render(request, 'question_list.html', {'questions': questions})

def question_detail(request, pk):
    questions = get_object_or_404(Question, pk=pk) # 게시글을 업로드 할 때마다 매기는 번호
    return render(request, 'question_detail.html', {'questions':questions}) # 화면에 보이게 렌더링

