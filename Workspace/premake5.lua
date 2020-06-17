workspace "SandboxBox2D"
    architecture "x86_64"
    startproject "BuildHelper"

	configurations
	{
		"Debug",
        "StaticLibRelease",
        --"DynamicLibRelease" This Is Not Supported As Box2D Does Not Export a single symbol by default.. If Atleast One Symbol is not exported the .lib file is not created
	}
	
	flags
	{
		"MultiProcessorCompile"
    }
	
	outputdir = "%{cfg.buildcfg}-%{cfg.platform}-%{cfg.system}-%{cfg.architecture}"

--Start Defining The Main Project

project "Box2D"
    location "box2d"

	language "C++"
    cppdialect "C++17"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
	{
		"%{prj.name}/include/box2d/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/src/**.h"
	}

	includedirs
	{
		"%{prj.name}/include",
		"%{prj.name}/src"
	}

    defines
	{
        "_CRT_SECURE_NO_WARNINGS"
	}
	
    filter "configurations:Debug"
		kind "StaticLib"
		runtime "Debug"
		symbols "on"
		staticruntime "on"

    filter "configurations:StaticLibRelease"
		kind "StaticLib"
		runtime "Release"
		optimize "on"
		staticruntime "on"
	
	filter ""


--Sandbox Project

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"box2d/include"
	}

	links
	{
		"Box2D"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		staticruntime "on"
		defines
		{
			"BOX2D_DEBUG_DEVELOP"
		}

	filter "configurations:StaticLibRelease"
		runtime "Release"
		optimize "on"
		staticruntime "on"

	filter ""

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"USINGBox2D"
	}