from django.shortcuts import render
from django import forms
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.contrib import messages
import time

class NewTaskForm(forms.Form):
    task = forms.CharField(
    max_length=20,
    label="",
    widget=forms.TextInput(attrs={
            'class': 'form',
            'placeholder': 'Enter a Task'
        })
    )
# Create your views here.

def index(request):
    if "tasks" not in request.session:
        request.session["tasks"] = []
    
    return render(request, "todo/index.html", {
        "tasks": list(enumerate(request.session["tasks"]))
    })

def add(request):
    if request.method == 'POST':
        form = NewTaskForm(request.POST)
        if form.is_valid():
            task = form.cleaned_data["task"]
            tasks = request.session.get("tasks", [])
            tasks.append(task) 
            request.session["tasks"] = tasks
            return HttpResponseRedirect(reverse("index"))
        else:
            return render(request, "todo/add.html", {
            "form": form
        })

    return render(request, "todo/add.html", {
        "form": NewTaskForm()
    })

def remove(request, task_index):
    if "tasks" in request.session:
        tasks = request.session["tasks"]
        if 0 <= task_index < len ("tasks"):
            tasks.pop(task_index)
            request.session["tasks"] = tasks
    return HttpResponseRedirect(reverse("index"))
